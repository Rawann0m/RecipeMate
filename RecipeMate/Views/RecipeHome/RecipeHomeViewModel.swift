//
//  RecipeHomeViewModel.swift
//  RecipeMate
//
//  Created by Rawan on 16/06/2025.
//
import SwiftUI

/// ViewModel responsible for handling recipe data fetching
/// Manages pagination, loadiing indicators, error handling and user search queries
class RecipeHomeViewModel: ObservableObject{
    
    //  MARK: - Properties
    
    @Published var recipes: [Recipe] = []
    @Published var filtered: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var showErrorAlert: Bool = false
    @Published var errorMessage: String = ""
    @Published var currentPage: Int = 1
    @Published var totalRecipes: Int = 0
    @Published var hasMore = true
    @Published var search: String = ""

    /// Fetches recipes from api based on the query
    /// Handles pagination, error state, and decoding the response into usable recipe data
    /// - Parameter query: The search keyword and by defaults it is "a" to load general results initially
    func fetchRecipes(query: String = "a") {
        // Stops from doing more calls if it is already loading or no more pages left
        guard !isLoading && hasMore else { return }
        
        isLoading = true
        let apiKey = Bundle.main.food2ForkApiKey
        let urlString = "https://food2fork.ca/api/recipe/search/?page=\(currentPage)&query=\(query)"
        
        // Make sure the URL is valid
        guard let url = URL(string: urlString) else{
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")
        
        print("\n=============================")
        print("API REQUEST")
        print("URL: \(request)")
        print("Method: GET")
        print("=============================\n")
        
        // Network request
        URLSession.shared.dataTask(with: request){ data, response, error in
            
            // Handle networking errors
            if let error = error{
                DispatchQueue.main.async{
                    self.errorMessage = "Network error: \(error.localizedDescription)"
                    self.showErrorAlert = true
                }
                print("\n Network Error: \(error.localizedDescription)\n")
                
            }
            
            // Ensure response is valid
            guard let httpResponse = response as? HTTPURLResponse else{
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid server response."
                }
                print("\n Invalid Response\n")
                return
            }
            
            print("\n=============================")
            print("API RESPONSE")
            print("URL: \(request)")
            print("Status Code: \(httpResponse.statusCode)")
            
            // Ensure response has data
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                    self.showErrorAlert = true
                }
                print("\n No Data Received\n")
                return
            }
            
            // Decode the JSON into recipe objects
            do {
                let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                DispatchQueue.main.async {
                    self.recipes.append(contentsOf: recipeResponse.results)
                    self.totalRecipes = recipeResponse.count
                    if !recipeResponse.results.isEmpty{
                        self.currentPage += 1
                    }
                    self.hasMore = self.recipes.count < self.totalRecipes
                    print("Fetched \(recipeResponse.results.count) recipes.  Total now: \(self.recipes.count)")
                    self.isLoading = false
                }
            } catch {
                
                // Handle decoding errors
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode data: \(error.localizedDescription)"
                    self.showErrorAlert = true
                    self.isLoading = false
                }
                print("\n JSON Decoding Error: \(error.localizedDescription)\n")
            }
        }
        .resume()
    }
}
