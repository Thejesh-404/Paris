//
//  MealDetailView.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel = MealDetailViewModel()
    let mealID: String
    
    var body: some View {
        ScrollView {
            if let meal = viewModel.meal {
                VStack(alignment: .leading) {
                    AsyncImage(url: meal.thumbnailURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)

                    
                    HStack() {
                        Spacer()
                        Text("Category: \(meal.category)")
                            .font(.subheadline)
                        Spacer()
                        Text("Area: \(meal.area)")
                            .font(.subheadline)
                        Spacer()
                    }
                    

                    
                    if let youtubeURL = meal.youtubeURL {
                        Link("Watch on YouTube", destination: youtubeURL)
                            .padding(.top)
                    }
                                        
                    
                    Text("Instructions")
                        .font(.headline)
                        .padding(.top)
                    
                    Text(meal.instructions)
                        .padding(.top)
                    
                    Text("Ingredients")
                        .font(.headline)
                        .padding(.top)
                    
                    ForEach(Array(zip(meal.ingredients, meal.measures)), id: \.0) { ingredient, measure in
                        Text("\(ingredient): \(measure)")
                            .padding(.top, 2)
                    }
                }
                .padding()
            } else if viewModel.isLoading {
                ProgressView()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle(viewModel.meal?.name ?? "Meal Details")
        .task {
            await viewModel.fetchMealDetails(mealID: mealID)
        }
    }
}

#Preview {
    NavigationView {
        MealDetailView(mealID: "53049")
    }
}

