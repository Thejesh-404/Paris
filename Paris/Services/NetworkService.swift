//
//  NetworkService.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import Foundation

struct NetworkService {
    
    static func fetchMeals() async throws -> [Meal] {
        
        let endpoint = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            return mealResponse.meals
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    static func fetchMealDetails(mealID: String) async throws -> DetailedMeal {
        let endpoint = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("Raw JSON data:")
            print(jsonString)
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let mealResponse = try JSONDecoder().decode(DetailedMealResponse.self, from: data)
            guard let meal = mealResponse.meals.first else {
                throw NetworkError.invalidData
            }
            return meal
        } catch {
            throw NetworkError.invalidData
        }
    }
    
}

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}

