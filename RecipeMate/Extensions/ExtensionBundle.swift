//
//  ExtensionBundle.swift
//  RecipeMate
//
//  Created by Rawan on 16/06/2025.
//
import SwiftUI

/// An extension to Bundle to safely access the Food2Fork API Key from Info.plist
extension Bundle {
    
    /// Retrives the api key stored in the app's Info.plist
    /// - Returns: a String which is the key
    var food2ForkApiKey: String{
        guard let key = object(forInfoDictionaryKey: "Food2ForkAPIKey") as? String else{
            fatalError("Api Key not found")
        }
        return key
    }
}
