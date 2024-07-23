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
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }

            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            return mealResponse.meals
        } catch is URLError {
            throw NetworkError.networkError
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    static func fetchMealDetails(mealID: String) async throws -> DetailedMeal {
        let endpoint = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }

            let mealResponse = try JSONDecoder().decode(DetailedMealResponse.self, from: data)
            guard let meal = mealResponse.meals.first else {
                throw NetworkError.invalidData
            }
            return meal
        } catch is URLError {
            throw NetworkError.networkError
        } catch {
            throw NetworkError.invalidData
        }
    }
    
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case networkError
    case invalidResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided was invalid."
        case .networkError:
            return "There was a problem connecting to the network. Please check your internet connection."
        case .invalidResponse:
            return "Received an invalid response from the server."
        case .invalidData:
            return "The data received from the server was invalid."
        }
    }
}

