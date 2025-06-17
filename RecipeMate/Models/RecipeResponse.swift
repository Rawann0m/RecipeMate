//
//  RecipeResponse.swift
//  RecipeMate
//
//  Created by Rawan on 16/06/2025.
//

/// A model of the response from the recipe API
struct RecipeResponse: Codable{
    let count: Int
    let next: String?
    let previous: String?
    let results: [Recipe]
}
