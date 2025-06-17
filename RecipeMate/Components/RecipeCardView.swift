//
//  RecipeCardView.swift
//  RecipeMate
//
//  Created by Rawan on 16/06/2025.
//
import SwiftUI
import SDWebImageSwiftUI

/// View that displays a card to show a single recipe
struct RecipeCardView: View{
    
    //  MARK: - Properties
    var recipe: Recipe
    @State private var isLoading: Bool = true
    
    //  MARK: - View
    
    var body: some View{
        VStack(spacing: 5){
            
            // Recipe Image
            WebImage(url: URL(string: recipe.featuredImage))
                .resizable()
                .onSuccess{_,_,_ in
                    // Image loaded, stop showing loading indicator
                    DispatchQueue.main.async {
                        isLoading = false
                    }
                }
                .onFailure{_ in
                    // Image not loaded, stop showing loading indicator
                    DispatchQueue.main.async {
                        isLoading = false
                    }
                }
                .overlay(
                    Group{
                        if isLoading{
                            // Loading indicator while image is being fetched
                            ProgressView()
                                .frame(width: 150,height: 150)
                        }
                    }
                )
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            // Recipe Title
            Text(recipe.title)
                .font(.subheadline)
                .bold()
                .dynamicTypeSize(.medium ... .accessibility5)
                .accessibilityLabel("Recipe Title: \(recipe.title)")
            // Recipe Publisher
            Text(recipe.publisher)
                .font(.caption)
                .dynamicTypeSize(.medium ... .accessibility5)
                .accessibilityLabel("Recipe Publisher: \(recipe.publisher)")
        }
        .frame(width: 180, height: 250)
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.white))
        .shadow(radius: 1)
        .padding(.top,5)
    }
}
