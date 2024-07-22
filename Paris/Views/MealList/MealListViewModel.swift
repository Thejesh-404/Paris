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
    @Published var errorMessage: String?
    
    func fetchMeals() async {
        
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            meals = mealResponse.meals
        } catch {
            errorMessage = "Failed to fetch meals"
        }
        
        isLoading = false
    }
}
