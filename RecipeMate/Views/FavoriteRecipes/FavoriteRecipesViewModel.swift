//
//  FavoriteRecipesViewModel.swift
//  RecipeMate
//
//  Created by Rawan on 17/06/2025.
//

import SwiftUI

/// ViewModel that manages the user favorite recipes
/// Stores favorites in UserDefaults
class FavoriteRecipesViewModel: ObservableObject{
    
    //  MARK: - Properties
    
    @Published var favoriteRecipes: [Recipe] = []
    private let key = "favoriteRecipes" // Used to store and load favorites from UserDefaults
    
    // Initializes the ViewModel and load the saved favorites
    init(){
        loadFavoriteRecipes()
    }
    
    /// Adds a recipe to favorites if it is not already there, or remove it if it is there
    /// - Parameter recipe: the Recipe to be added or removed
    func addFavoriteRecipe(_ recipe: Recipe){
        if let index = favoriteRecipes.firstIndex(where: {$0.id == recipe.id}){
            // If recipe is already a favorite, remove it
            favoriteRecipes.remove(at: index)
        } else{
            // Recipe not a favorite, add it
            favoriteRecipes.append(recipe)
        }
        saveFavoriteRecipes()
    }
    
    /// Checks if a recipe is marked as favorite
    /// - Parameter recipe: the recipe to check
    /// - Returns: a Boolean vlaue indicating if the recipe is a favortie
    func isFavorite(_ recipe: Recipe) -> Bool {
        favoriteRecipes.contains(where: {$0.id == recipe.id})
    }
    
    /// Loads favorite recipes from UserDefaults
    private func loadFavoriteRecipes(){
        if let savedData = UserDefaults.standard.data(forKey: key){
            do{
                favoriteRecipes = try JSONDecoder().decode([Recipe].self, from: savedData)
            } catch{
                print("Error loading favorite recipes: \(error)")
            }
        }
    }
    
    /// Saves the list of favorite recipes to UserDefaults
    private func saveFavoriteRecipes(){
        do{
            let savedData = try JSONEncoder().encode(favoriteRecipes)
            UserDefaults.standard.set(savedData, forKey: key)
        } catch{
            print("Error saving favorite recipes: \(error)")
        }
    }
}
