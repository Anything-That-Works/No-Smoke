//
//  HomeView.swift
//  No Smoke
//
//  Created by Promal on 18/10/23.
//

import SwiftUI

struct HomeView: View {
  @Environment(HealthManager.self) var manager
  let welcomeColors: [Color] = [.red, .green, .yellow]
  @State var colorIndex = 0
  var body: some View {
    VStack {
      Text("Welcome")
        .font(.largeTitle.bold())
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(welcomeColors[colorIndex])
        .onAppear(perform: welcomeTimer)
        .animation(.linear, value: colorIndex)
      LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2), content: {
        ForEach(manager.activities.sorted(by: {$0.value.id < $1.value.id}), id: \.key) { item in
          ActivityCard(activity: item.value)
        }
      })
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
  }
  func welcomeTimer() {
    Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
      colorIndex = (colorIndex + 1) % welcomeColors.count
    }
  }
}

#Preview {
  HomeView()
    .environment(HealthManager())
}
