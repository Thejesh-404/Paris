//
//  DetailedMeal.swift
//  Paris
//
//  Created by Thejesh on 7/22/24.
//

import Foundation

struct DetailedMeal: Identifiable, Decodable {
    let id: String
    let name: String
    let category: String
    let area: String
    let instructions: String
    let thumbnailURL: URL
    let youtubeURL: URL?
    let ingredients: [String]
    let measures: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case thumbnailURL = "strMealThumb"
        case youtubeURL = "strYoutube"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decode(String.self, forKey: .category)
        area = try container.decode(String.self, forKey: .area)
        instructions = try container.decode(String.self, forKey: .instructions)
        thumbnailURL = try container.decode(URL.self, forKey: .thumbnailURL)
        youtubeURL = try? container.decode(URL.self, forKey: .youtubeURL)
        
        var ingredients: [String] = []
        var measures: [String] = []
        
        let additionalInfo = try decoder.container(keyedBy: DynamicCodingKeys.self)
        for key in additionalInfo.allKeys {
            if key.stringValue.starts(with: "strIngredient"), let ingredient = try? additionalInfo.decode(String.self, forKey: key), !ingredient.isEmpty {
                ingredients.append(ingredient)
            } else if key.stringValue.starts(with: "strMeasure"), let measure = try? additionalInfo.decode(String.self, forKey: key), !measure.trimmingCharacters(in: .whitespaces).isEmpty {
                measures.append(measure)
            }
        }
        
        self.ingredients = ingredients
        self.measures = measures
    }
}

struct DetailedMealResponse: Decodable {
    let meals: [DetailedMeal]
}

struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    var intValue: Int?
    init?(intValue: Int) {
        return nil
    }
}

