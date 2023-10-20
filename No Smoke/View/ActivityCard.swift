//
//  ActivityCard.swift
//  No Smoke
//
//  Created by Promal on 18/10/23.
//

import SwiftUI


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
        .lineLimit(1)
        .minimumScaleFactor(0.4)
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
