//
//  ContentView.swift
//  No Smoke
//
//  Created by Promal on 18/10/23.
//

import SwiftUI

struct NoSmokeTabView: View {
  @State var selectedTab = "Home"
  @Environment(HealthManager.self) var manager
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeView()
        .tag("Home")
        .tabItem {
          Image(systemName: "house")
        }
      ContentView()
        .tag("Content")
        .tabItem {
          Image(systemName: "figure.mind.and.body")
        }
    }
  }
}

#Preview {
  NoSmokeTabView()
    .environment(HealthManager())
}
