//
//  MealRow.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import SwiftUI

struct MealRow: View {
    let meal: Meal
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: meal.thumbnailURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            .cornerRadius(8)
            
            Text(meal.name)
                .font(.headline)
            
        }
    }
}

#Preview {
    MealRow(meal:  Meal(
        id: "53049",
        name: "Apam balik",
        thumbnailURL: URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!
    ))
}
