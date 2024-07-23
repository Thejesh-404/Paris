//
//  MealListView.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject private var viewModel = MealListViewModel()
    var body: some View {
        NavigationView {
            VStack {
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                            
                List(viewModel.filteredMeals) { meal in
                    NavigationLink{
                        MealDetailView(mealID: meal.id)
                    } label: {
                        MealRow(meal: meal)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Desserts")
                .searchable(text: $viewModel.searchText)
                .overlay(Group {
                    if viewModel.isLoading {
                        ProgressView()
                    }
                })
            }
        }
        .task {
            await viewModel.fetchMeals()
        }
    }
}


#Preview {
    MealListView()
}
