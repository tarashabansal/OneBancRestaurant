//
//  OneBancRestaurantApp.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//

import SwiftUI

@main
struct OneBancRestaurantApp: App {
    @StateObject var cartViewModel = CartViewModel()
    @StateObject var languageManager = LanguageManager()
    init() {
           let appearance = UINavigationBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.backgroundColor = UIColor.black
           appearance.titleTextAttributes = [
            .foregroundColor: UIColor.yellow,
            .font: UIFont.systemFont(ofSize: 16)
           ]

           UINavigationBar.appearance().standardAppearance = appearance
           UINavigationBar.appearance().scrollEdgeAppearance = appearance
       }
    
        var body: some Scene {
            WindowGroup {
                HomeScreen()
                    .environmentObject(cartViewModel)
                    .environmentObject(languageManager)
            }
        }
}
