//
//  Activity.swift
//  No Smoke
//
//  Created by Promal on 20/10/23.
//

import Foundation

struct Activity: Identifiable {
  let id: String
  let title: String
  let subTitle: String
  let image: String
  var amount: String
  
  static func stepsPlaceholder() -> Activity {
    return Activity(id: "0",title: "Today Steps", subTitle: "Goal: 10,000", image: "figure.walk", amount: "0")
  }
  static func caloriesPlaceholder() -> Activity {
    return Activity(id: "1",title: "Today Calories", subTitle: "Goal: 900", image: "flame", amount: "0")
  }
  static func runningActivityPlaceholder() -> Activity {
    return Activity(id: "2",title: "Running", subTitle: "This Week", image: "figure.run", amount: "0 min")
  }
  static func strengthTrainingActivityPlaceholder() -> Activity {
    return Activity(id: "3",title: "Weight Lifting", subTitle: "This Week", image: "figure.strengthtraining.traditional", amount: "0 min")
  }
  static func soccerActivityPlaceholder() -> Activity {
    return Activity(id: "4",title: "Soccer", subTitle: "This Week", image: "figure.soccer", amount: "0 min")
  }
  static func basketballActivityPlaceholder() -> Activity {
    return Activity(id: "5",title: "Basketball", subTitle: "This Week", image: "figure.basketball", amount: "0 min")
  }
}
