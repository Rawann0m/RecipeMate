//
//  Recipe.swift
//  RecipeMate
//
//  Created by Rawan on 16/06/2025.
//

/// A model of a recipe item conforming to Identifiable, Codable, Equatable
struct Recipe: Identifiable, Codable, Equatable{
    let id: Int
    let title: String
    let publisher: String
    let featuredImage: String
    let rating: Int
    let sourceURL: String
    let description: String?
    let cookingInstructions: String?
    let ingredients: [String]
    let dateAdded: String
    let dateUpdated: String
    let longDateAdded: Int
    let longDateUpdated: Int
    
    // Custom mapping between JSON keys and Swift properties
    enum CodingKeys: String, CodingKey {
        case id = "pk"
        case title
        case publisher
        case featuredImage = "featured_image"
        case rating
        case sourceURL = "source_url"
        case description
        case cookingInstructions = "cooking_instructions"
        case ingredients
        case dateAdded = "date_added"
        case dateUpdated = "date_updated"
        case longDateAdded = "long_date_added"
        case longDateUpdated = "long_date_updated"
        
    }
}
