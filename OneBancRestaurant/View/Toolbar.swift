//
//  Toolbar.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/25/25.
//


import SwiftUI

struct Toolbar: ToolbarContent {
    @EnvironmentObject var languageManager : LanguageManager
    let pageName: String
        var body: some ToolbarContent {
            if pageName != "Home"{
                ToolbarItem(placement: .navigationBarLeading) {
                    BackButton()
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Text("\(pageName)")
                    .foregroundColor(Color.white)
                    .font(.title3)
                
            }
            if pageName != "Cart"{
                ToolbarItem(placement: .navigationBarTrailing) {
                    CartViewModel.CartButton()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    languageManager.toggleLanguage()
                }) {
                    Image(systemName: "globe")
                        .font(.body)
                        .foregroundColor(.white)
                }
            }
        }
    }
