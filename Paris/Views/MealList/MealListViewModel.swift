//
//  MealListViewModel.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var isLoading = false
    @Published var searchText: String = ""
    
    var filteredMeals: [Meal] {
        if searchText.isEmpty {
            return meals
        } else {
            return meals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    func fetchMeals() async {
       
        isLoading = true
        
        do {
            meals = try await NetworkService.fetchMeals()
        } catch {
            print("Failed to fetch meals: \(error)")
        }
        
        isLoading = false
    }
}


enum MealListError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
