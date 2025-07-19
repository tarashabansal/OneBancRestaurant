//
//  LanguageManager.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/19/25.
//


// LanguageManager.swift
import SwiftUI

class LanguageManager: ObservableObject {
    @Published var currentLanguage: Language = .english
    
    enum Language {
        case english
        case hindi
    }
    
    func toggleLanguage() {
        currentLanguage = (currentLanguage == .english) ? .hindi : .english
    }
    
    func localText(_ en: String, _ hi: String, language: LanguageManager.Language) -> String {
        return language == .english ? en : hi
    }
}
