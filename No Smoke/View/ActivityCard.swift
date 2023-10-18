//
//  ActivityCard.swift
//  No Smoke
//
//  Created by Promal on 18/10/23.
//

import SwiftUI

struct Activity: Identifiable {
  let id = UUID()
  let title: String
  let subTitle: String
  let image: String
  let amount: String
  
  static func stepsPlaceholder() -> Activity {
    return Activity(title: "Today Steps", subTitle: "Goal: 10,000", image: "figure.walk", amount: "0")
  }
  static func caloriesPlaceholder() -> Activity {
    return Activity(title: "Today Calories", subTitle: "Goal: 900", image: "flame", amount: "0")
  }
  
}


struct ActivityCard: View {
  @State var activity: Activity
  var body: some View {
    VStack {
      HStack(alignment: .top) {
        VStack(alignment: .leading) {
          Text(activity.title)
            .font(.callout)
          Text(activity.subTitle)
            .font(.caption)
            .foregroundStyle(.gray)
        }
        Spacer()
        Image(systemName: activity.image)
          .foregroundStyle(.green)
      }
      .padding(.bottom)
      Text(activity.amount)
        .font(.largeTitle)
    }
    
    .padding()
    .background(Color(uiColor: .systemGray6))
    .clipShape (
      RoundedRectangle(cornerRadius: 10)
    )
  }
}

#Preview {
  ActivityCard(activity: Activity.stepsPlaceholder())
}
