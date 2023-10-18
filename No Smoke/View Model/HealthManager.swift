//
//  HealthManager.swift
//  No Smoke
//
//  Created by Promal on 18/10/23.
//

import Foundation
import HealthKit

enum HealthData: String {
  case todayCalories, todaySteps
}

@Observable class HealthManager {
  let healthStore = HKHealthStore()
  var activities = [String: Activity]()
  init() {
    let steps = HKQuantityType(.stepCount)
    let calories = HKQuantityType(.activeEnergyBurned)
    let healthTypes: Set = [steps, calories]
    
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
      } catch {
        print("Error fetching health data")
      }
    }
  }
  
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
      let activity = Activity(title: placeHolder.title, subTitle: placeHolder.subTitle, image: placeHolder.image, amount: result.formattedString())
      DispatchQueue.main.async {
        self.activities[key.rawValue] = activity
      }
      print(result)
    }
    healthStore.execute(query)
  }
}



