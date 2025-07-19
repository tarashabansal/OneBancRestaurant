//
//  Menu.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var languageManager :  LanguageManager
    @StateObject private var viewModel: CuisineViewModel = CuisineViewModel()
    let selectedCuisine: String
   
    var body: some View {
        VStack{
            Color.clear.frame(height: 20)
            let filteredCuisines = viewModel.cuisines.filter { $0.cuisine_name == selectedCuisine }
            Text(selectedCuisine)
                .font(.title3)
                .bold()
            
            List(filteredCuisines) { cuisine in
                ForEach(cuisine.items, id: \.id) { dish in
                    MenuListItem(cuisineId: cuisine.cuisine_id, dish: dish)
                }
            }
            .onAppear{
                viewModel.fetchCuisinesIfNeeded()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(languageManager.localText("OneBanc Restaurant","वनबैंक रेस्तरां",language: languageManager.currentLanguage))
                    .foregroundColor(Color.yellow)
                    .bold()
                    .font(.title2)
                
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                CartViewModel.CartButton()
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    languageManager.toggleLanguage()
                }) {
                    Image(systemName: "globe")
                        .font(.body)
                        .padding()
                        .foregroundColor(.white)
                }
            }
        }
        .padding(20)
    }
    
}

#Preview {
    Menu(selectedCuisine: "North Indian")
        .environmentObject(CartViewModel()).environmentObject(LanguageManager())
}
