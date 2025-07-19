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
            VStack(alignment:.leading){
                Color.clear.frame(height: 20)
                Text(languageManager.localText("Cuisines", "व्यंजन के प्रकार", language: languageManager.currentLanguage))
                    .font(.title3)
                    .bold()
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                CuisineCard()
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                Text(languageManager.localText("Favourite Dishes", "पसंदीदा खाना", language: languageManager.currentLanguage))
                    .font(.title3)
                    .bold()
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                TopDishes()
                    .padding(20)
                NavigationLink(destination: Cart()) {
                    Text(languageManager.localText("Go to Cart", "कार्ट पर जाएं", language: languageManager.currentLanguage))
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
                
            }
            .frame(alignment: .topLeading)
            .navigationBarBackButtonHidden(true)    
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
            .padding()
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(CartViewModel())
        .environmentObject(LanguageManager())
}
