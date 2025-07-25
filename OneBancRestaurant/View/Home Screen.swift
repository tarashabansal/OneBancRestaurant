//
//  Home Screen.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var languageManager : LanguageManager
    var body: some View {
        
        NavigationStack {
            VStack(){
                CuisineCard()
                Text(languageManager.localText("Favourite Dishes", "पसंदीदा खाना", language: languageManager.currentLanguage))
                    .font(.body)
                    .bold()
                    .frame(width: 380, alignment: .leading)
                TopDishes()
                    .padding(.horizontal,20)
                Spacer()
                
            }
            .frame(alignment: .topLeading)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                Toolbar(pageName: "Home")
            }
            
        }
        
        
    }
}

#Preview {
    HomeScreen()
        .environmentObject(CartViewModel())
        .environmentObject(LanguageManager())
}
