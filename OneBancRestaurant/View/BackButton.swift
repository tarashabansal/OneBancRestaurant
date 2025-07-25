//
//  BackButton.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/25/25.
//
import SwiftUI


struct BackButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
        }
    }
}
