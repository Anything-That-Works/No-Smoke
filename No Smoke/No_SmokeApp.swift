//
//  No_SmokeApp.swift
//  No Smoke
//
//  Created by Promal on 18/10/23.
//

import SwiftUI

@main
struct No_SmokeApp: App {
  @State var manager = HealthManager()
  var body: some Scene {
    WindowGroup {
      NoSmokeTabView()
        .environment(manager)
    }
  }
}
