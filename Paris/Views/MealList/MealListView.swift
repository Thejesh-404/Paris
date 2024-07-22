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
                            
                List(viewModel.filteredMeals) { meal in
                    NavigationLink{
                        MealDetailView(mealID: meal.id)
                    } label: {
                        MealRowView(meal: meal)
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
