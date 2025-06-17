//
//  RecipeHomeView.swift
//  RecipeMate
//
//  Created by Rawan on 16/06/2025.
//
import SwiftUI

/// The main view displaying a list of recipes and favorite recipes
/// User can search, scroll through results, and toggle between all and favorite recipes
struct RecipeHomeView: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = RecipeHomeViewModel()
    @StateObject private var favoriteViewModel = FavoriteRecipesViewModel()
    @State private var goToDetails = false
    @State private var selectedRecipe: Recipe?
    @State private var showFavorite = false
    
    //  MARK: - View
    
    var body: some View {
        NavigationStack{
            
            // Top bar
            topBar()
            
            // Recipe list
            ScrollView(showsIndicators: false) {
                VStack(){
                    
                    // Grid layout of recipe cards
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 250), spacing: 20)],spacing: 15){
                        let results = showFavorite ? favoriteViewModel.favoriteRecipes : viewModel.recipes
                        
                        ForEach(results.indices, id: \.self){ index in
                            let recipe = results[index]
                            
                            NavigationLink(destination: RecipeDetailsView(recipe: recipe, favoriteViewModel: favoriteViewModel)) {
                                RecipeCardView(recipe: recipe)
                            }
                            .foregroundColor(.black)
                            .onAppear{
                                // This will trigger pagination when the user is reaching to the end of the list
                                if index == viewModel.recipes.count - 2 && !viewModel.isLoading {
                                    viewModel.fetchRecipes(query: viewModel.search.isEmpty ? "a" : viewModel.search)
                                }
                                
                            }
                        }
                        
                    }
                    
                    // Loaidng indicator
                    if viewModel.isLoading{
                        ProgressView()
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    
                    // Message if the user is searching for somthing isnt in the api
                    if viewModel.recipes.isEmpty && !viewModel.search.isEmpty{
                        Text("No recipes found")
                            .foregroundColor(.gray)
                            .padding()
                            .dynamicTypeSize(.medium ... .accessibility5)
                            .accessibilityLabel("No recipes found")
                    }
                    
                    // Message if the favorite lisy is empty
                    if favoriteViewModel.favoriteRecipes.isEmpty && showFavorite{
                        Text("No favorite recipes found")
                            .foregroundColor(.gray)
                            .padding()
                            .dynamicTypeSize(.medium ... .accessibility5)
                            .accessibilityLabel("No favorite recipes found")
                    }
                }
                .padding(.horizontal)
            }
            
            // Error alert
            .alert(viewModel.errorMessage, isPresented: $viewModel.showErrorAlert){
                Button("OK", role: .cancel){}
            }
            
            // Fetch when the page appear
            .onAppear {
                if viewModel.recipes.isEmpty{
                    viewModel.fetchRecipes()
                }
            }
            
        }
    }
}

// Top bar including the title and the toggle filter button and the search bar
private extension RecipeHomeView{
    @ViewBuilder
    func topBar() -> some View{
        VStack{
            HStack{
                // Title
                Text("Meals Recipes")
                    .font(.title2)
                    .bold()
                    .dynamicTypeSize(.medium ... .accessibility5)
                    .accessibilityLabel("Meals Recipes")
                
                Spacer()
                
                // Filter button to toggle between all and favorite recipes 
                Button(action:{
                    showFavorite.toggle()
                }){
                    Image("filter")
                        .resizable()
                        .frame(width: 25,height: 25)
                        .opacity(0.5)
                }
            }
            // Search bar
            SearchBarView(viewModel: viewModel)
        }
        .padding()
    }
}
