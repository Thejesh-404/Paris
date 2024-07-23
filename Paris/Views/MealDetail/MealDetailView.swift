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
        ZStack {
            if let meal = viewModel.meal {
                ScrollView {
                    VStack(alignment: .leading) {
                        AsyncImage(url: meal.thumbnailURL) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity)
                        
                        HStack {
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
                        
                        IngredientsTable(ingredients: meal.ingredients, measures: meal.measures)
                    }
                    .padding()
                }
                .navigationTitle(meal.name)
            } else if viewModel.isLoading {
                VStack {
                    ProgressView()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(.systemBackground))
                .ignoresSafeArea()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
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



