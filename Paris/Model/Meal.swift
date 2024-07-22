//
//  Meal.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import Foundation

struct Meal: Identifiable, Decodable {
    let id: String
    let name: String
    let thumbnailURL: URL

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
    }
}

struct MealResponse: Decodable {
    let meals: [Meal]
}
