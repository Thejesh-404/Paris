//
//  MealDetailView.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject private var viewModel = MealDetailViewModel()
    @State private var imageScale: CGFloat = 0.8
    let mealID: String
    
    var body: some View {
        ZStack {
            if let meal = viewModel.meal {
                ScrollView {
                    VStack(alignment: .leading) {
                        AsyncImage(url: meal.thumbnailURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                        
                    
                        
                        VStack(alignment: .leading, spacing: 15) {
                                Text("Instructions")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                Text(meal.instructions)
                                    .font(.body)
                                    .lineSpacing(5)
                            
                                HStack {
                                    Label(meal.area, systemImage: "mappin.circle.fill")
                                    Spacer()
                                    if let youtubeURL = meal.youtubeURL {
                                        Link(destination: youtubeURL) {
                                            Label("Watch", systemImage: "play.circle.fill")
                                        }
                                    }
                                }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(8)
                                                
                        IngredientsTable(ingredients: meal.ingredients, measures: meal.measures)
                            .cornerRadius(8)
                            
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



