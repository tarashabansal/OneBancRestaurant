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
        NavigationStack{
            VStack{
                let filteredCuisines = viewModel.cuisines.filter { $0.cuisine_name == selectedCuisine }
                List(filteredCuisines) { cuisine in
                    Section(
                        header: Text("\(selectedCuisine)")
                        .font(.body)
                        .bold())
                    {
                        ForEach(cuisine.items, id: \.id) { dish in
                            MenuListItem(cuisineId: cuisine.cuisine_id, dish: dish)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .onAppear{
                    viewModel.fetchCuisinesIfNeeded()
                }
                Spacer()
                NavigationLink(destination: Cart()) {
                    Text(languageManager.localText("Proceed to Checkout", "कार्ट पर जाएं", language: languageManager.currentLanguage))
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            Toolbar(pageName: "Menu")
        }
    }
}

#Preview {
    Menu(selectedCuisine: "North Indian")
        .environmentObject(CartViewModel()).environmentObject(LanguageManager())
}
