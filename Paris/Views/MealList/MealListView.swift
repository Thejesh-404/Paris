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
            List(viewModel.meals) { meal in
                MealRowView(meal: meal)
            }
            .navigationTitle("Desserts")
            .overlay(Group {
                if viewModel.isLoading {
                    ProgressView()
                }
            })
            .alert(item: Binding<AlertItem?>(
                get: { viewModel.errorMessage.map { AlertItem(message: $0) } },
                set: { _ in viewModel.errorMessage = nil }
            )) { alertItem in
                Alert(title: Text("Error"), message: Text(alertItem.message))
            }
        }
        .task {
            await viewModel.fetchMeals()
        }
    }
}



struct AlertItem: Identifiable {
    let id = UUID()
    let message: String
}




#Preview {
    MealListView()
}
