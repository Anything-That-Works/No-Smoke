//
//  Helpers.swift
//  No Smoke
//
//  Created by Promal on 18/10/23.
//

import Foundation

extension Double {
  func formattedString() -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.maximumFractionDigits = 0
    return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
  }
}

extension Date {
  static var startOfDay: Date {
    Calendar.current.startOfDay(for: Date.now)
  }
}

extension Date {
  static func startOfWeek(for date: Date = Date.now, using calendar: Calendar = .current) -> Date {
      var calendar = calendar
      calendar.firstWeekday = 2 // Sunday as the first day of the week (you can adjust this based on your needs)
      var components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
      components.weekday = calendar.firstWeekday
      return calendar.date(from: components)!
  }
}
