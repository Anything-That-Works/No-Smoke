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
