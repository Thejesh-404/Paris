//
//  NetworkService.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import Foundation

struct NetworkService {
    
    // Function to fetch a list of meals
    static func fetchMeals() async throws -> [Meal] {
        
        let endpoint = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        
        // Validate the URL
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        do {
            // Perform network request
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validate HTTP response status
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }

            // Decode JSON response
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            return mealResponse.meals
        } catch is URLError {
            throw NetworkError.networkError
        } catch {
            throw NetworkError.invalidData
        }
    }
    
    // Function to fetch detailed information about a specific meal
    static func fetchMealDetails(mealID: String) async throws -> DetailedMeal {
        let endpoint = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)"
        
        // Validate the URL
        guard let url = URL(string: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        do {
            // Perform network request
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validate HTTP response status
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }

            // Decode JSON response
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

// Custom error types for network operations
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case networkError
    case invalidResponse
    case invalidData
    
    // Error descriptions for localized error messages
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


