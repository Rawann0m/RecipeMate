//
//  SearchBar.swift
//  RecipeMate
//
//  Created by Rawan on 16/06/2025.
//
import SwiftUI

/// Search bar view that allows user to search for a recipe
/// Automatically triggers a new fetch when the user submit or clear the search input
struct SearchBarView: View{
    
    //  MARK: - Properties
    @ObservedObject var viewModel: RecipeHomeViewModel
    
    //  MARK: - View
    
    var body: some View{
        HStack{
            
            // Icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
                .padding(.leading)
            
            // Text field
            TextField("Search meal name", text: $viewModel.search)
                .textInputAutocapitalization(.none)
                .onSubmit {
                    // When user submit reset page and fetch new data
                    viewModel.currentPage = 1
                    viewModel.recipes.removeAll()
                    viewModel.fetchRecipes(query: viewModel.search.isEmpty ? "a" : viewModel.search)
                }
                .onChange(of:viewModel.search){ _, newValue in
                    // If the input is cleared refetch with default query
                    if newValue.isEmpty{
                        viewModel.currentPage = 1
                        viewModel.recipes.removeAll()
                        viewModel.fetchRecipes(query: viewModel.search.isEmpty ? "a" : viewModel.search)
                    }
                    
                }
        }
        .frame(maxWidth:.infinity)
        .frame(height: 50)
        .background(.gray.opacity(0.1))
        .cornerRadius(10)
    }
}
