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
            if let networkError = error as? NetworkError {
                errorMessage = networkError.localizedDescription
            } else {
                errorMessage = "An unexpected error occurred."
            }
        }
        
        isLoading = false
    }
}

