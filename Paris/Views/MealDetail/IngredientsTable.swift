//
//  IngredientsTable.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import SwiftUI

struct IngredientsTable: View {
    let ingredients: [String]
    let measures: [String]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Ingredient")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Measure")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 2)
            .padding(.vertical, 8)
            .background(Color.gray.opacity(0.2))
            
            ForEach(Array(zip(ingredients, measures).enumerated()), id: \.offset) { index, item in
                HStack {
                    Text(item.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(item.1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 2)
                .padding(.vertical, 8)
                .background(index % 2 == 0 ? Color.clear : Color.gray.opacity(0.1))
            }
        }
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

#Preview {
    IngredientsTable(       
        ingredients: [
        "Chicken Breast",
        "Salt",
        "Black Pepper",
        "Olive Oil",
        "Onion",
        "Garlic",
        "Tomatoes",
        "Basil"
    ],
    measures: [
        "2 pieces",
        "1 tsp",
        "1/2 tsp",
        "2 tbsp",
        "1 medium",
        "2 cloves",
        "3 large",
        "A handful"
    ])
}
