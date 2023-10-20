//
//  HealthManager.swift
//  No Smoke
//
//  Created by Promal on 18/10/23.
//

import Foundation
import HealthKit

enum HealthData: String {
  case todayCalories, todaySteps, strength, running, soccer, basketball
}

@Observable class HealthManager {
  let healthStore = HKHealthStore()
  var activities = [String: Activity]()
  init() {
    let steps = HKQuantityType(.stepCount)
    let calories = HKQuantityType(.activeEnergyBurned)
    let workout = HKObjectType.workoutType()
    let healthTypes: Set = [steps, calories, workout]
    
    Task {
      do {
        try await healthStore.requestAuthorization(toShare:[], read: healthTypes)
        
        fetchTodaysData(for: HKQuantityType(.activeEnergyBurned),
                        to: .todayCalories,
                        placeHolder: .caloriesPlaceholder(),
                        unit: .kilocalorie())
        
        fetchTodaysData(for: HKQuantityType(.stepCount),
                        to: .todaySteps,
                        placeHolder: .stepsPlaceholder(),
                        unit: .count())
        fetchWeeksWorkout()
      } catch {
        print("Error fetching health data")
      }
    }
  }
  //MARK: - For HKQuantityType
  func fetchTodaysData(for type: HKQuantityType, to key: HealthData, placeHolder: Activity, unit: HKUnit) {
    let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: .now)
    let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate) { _, result, error in
      guard let error = error else {
        return print("Error in fetchTodaysCalories: \(String(describing: error))")
      }
      guard let quantity = result?.sumQuantity() else {
        DispatchQueue.main.async {
          self.activities[key.rawValue] = placeHolder
        }
        print("fetchTodaysCalories quantity not populated: \(error.localizedDescription)")
        return
      }
      let result = quantity.doubleValue(for: unit)
      let activity = Activity(id: placeHolder.id,title: placeHolder.title, subTitle: placeHolder.subTitle, image: placeHolder.image, amount: result.formattedString())
      DispatchQueue.main.async {
        self.activities[key.rawValue] = activity
      }
      print(result)
    }
    healthStore.execute(query)
  }
  
  
  func fetchWeeksWorkout() {
    let workout = HKSampleType.workoutType()
    let predicate = HKQuery.predicateForSamples(withStart: .startOfWeek(), end: Date.now)
    let query = HKSampleQuery(sampleType: workout,
                              predicate: predicate,
                              limit: HKObjectQueryNoLimit,
                              sortDescriptors: nil) { _, sample, error in
      
      guard let workouts = sample as? [HKWorkout], error == nil else {
        return print("Error in fetchWeeksWorkout: \(String(describing: error))" )
      }
      
      var runningCount = Int()
      var strengthCount = Int()
      var soccerCount = Int()
      var basketballCount = Int()
      
      for workout in workouts {
        if workout.workoutActivityType == .running {
          let duration = Int(workout.duration) / 60
          runningCount += duration
        } else if workout.workoutActivityType == .traditionalStrengthTraining {
          let duration = Int(workout.duration) / 60
          strengthCount += duration
        } else if workout.workoutActivityType == .soccer {
          let duration = Int(workout.duration) / 60
          soccerCount += duration
        } else if workout.workoutActivityType == .basketball {
          let duration = Int(workout.duration) / 60
          basketballCount += duration
        }
      }
      var runningActivity = Activity.runningActivityPlaceholder()
      runningActivity.amount = "\(runningCount) min"
      
      var strengthTrainingActivity = Activity.strengthTrainingActivityPlaceholder()
      strengthTrainingActivity.amount = "\(strengthCount) min"
      
      var soccerActivity = Activity.soccerActivityPlaceholder()
      soccerActivity.amount = "\(soccerCount) min"
      
      var basketballActivity = Activity.basketballActivityPlaceholder()
      basketballActivity.amount = "\(basketballCount) min"
      
      DispatchQueue.main.async {
        self.activities[HealthData.running.rawValue] = runningActivity
        self.activities[HealthData.strength.rawValue] = strengthTrainingActivity
        self.activities[HealthData.soccer.rawValue] = soccerActivity
        self.activities[HealthData.basketball.rawValue] = basketballActivity
      }
    }
    healthStore.execute(query)
  }
}





