//
//  RecipeDetailsView.swift
//  RecipeMate
//
//  Created by Rawan on 16/06/2025.
//
import SwiftUI
import SDWebImageSwiftUI

/// Detalied view showing all the information of a selected recipe
/// Displays the recipe image, title, ingredients, cooking instructions and publisher name
/// Allow the user to add and remove the recipe from favorite 
struct RecipeDetailsView: View{
    
    //  MARK: - Properies
    
    var recipe: Recipe
    @ObservedObject var favoriteViewModel: FavoriteRecipesViewModel
    @Environment(\.dismiss) var dismiss
    
    // MARK: - View
    
    var body: some View{
        ScrollView{
            VStack{
                // Recipe Image
                WebImage(url: URL(string: recipe.featuredImage))
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .cornerRadius(12)
                    .clipped()
                    .padding(.horizontal)
                
                // Recipe details
                recipeDetailsSection
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            // Back button
            ToolbarItem(placement: .topBarLeading){
                Button(action: {
                    dismiss()
                }){
                    Image(systemName: "arrow.left")
                        .frame(width: 35,height: 35)
                        .foregroundColor(.black)
                }
            }
            // Title
            ToolbarItem(placement: .principal){
                Text("Recipe Detail")
                    .font(.title)
                    .bold()
                    .dynamicTypeSize(.medium ... .accessibility5)
                    .accessibilityLabel("Recipe Detail")
            }
            // Favorite button
            ToolbarItem(placement: .topBarTrailing){
                Button(action: {
                    favoriteViewModel.addFavoriteRecipe(recipe)
                }){
                    Image(systemName: favoriteViewModel.isFavorite(recipe) ? "heart.fill" : "heart")
                        .foregroundColor(favoriteViewModel.isFavorite(recipe) ? .red : .black)
                        .frame(width: 35,height: 35)
                }
            }
        }
    }
    
    /// Private computed view that shows all the details for the recipe
    private var recipeDetailsSection: some View{
        VStack(alignment: .leading, spacing: 15){
            // Recipe Title
            Text(recipe.title)
                .font(.title2)
                .bold()
                .dynamicTypeSize(.medium ... .accessibility5)
                .accessibilityLabel("Recipe Title: \(recipe.title)")
            // Ingredients
            Text("Ingredients")
                .font(.title3)
                .bold()
            Text(recipe.ingredients.joined(separator: "\n"))
                .font(.subheadline)
                .dynamicTypeSize(.medium ... .accessibility5)
                .accessibilityLabel("Ingredients: \(recipe.ingredients.joined(separator: "\n"))")
            // Cooking Instructions
            Text("Cooking Instructions")
                .font(.title3)
                .bold()
            Text(recipe.cookingInstructions ?? "No cooking instructions found")
                .font(.subheadline)
                .dynamicTypeSize(.medium ... .accessibility5)
                .accessibilityLabel("Cooking Instructions: \(recipe.cookingInstructions ?? "No cooking instructions found")")
            // Recipe Publisher
            Text("Recipe Publisher")
                .font(.title3)
                .bold()
            Text(recipe.publisher)
                .font(.subheadline)
                .dynamicTypeSize(.medium ... .accessibility5)
                .accessibilityLabel("Recipe Publisher: \(recipe.publisher)")
        }
        .frame(maxWidth: .infinity)
    }
}


