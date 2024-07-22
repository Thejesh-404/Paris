//
//  MealDetailViewModel.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published var meal: DetailedMeal?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchMealDetails(mealID: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            meal = try await NetworkService.fetchMealDetails(mealID: mealID)
        } catch {
            errorMessage = "Failed to fetch meal details"
        }
        
        isLoading = false
    }
}

