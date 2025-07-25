//
//  Failure Dialog.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/19/25.
//

import SwiftUI

struct FailureDialog: View {
    @Binding var isActive: Bool

    var title: String = "Failed to place the order!"
    var message: String = "Some issues occurred while placing your order. Please try again later."
    var buttonTitle: String = "Go to Home"
    
    @State private var offset: CGFloat = 1000

    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.5)
                .onTapGesture {
                    close()
                }

            VStack {
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding()
                    .foregroundColor(.black)
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.black)
                Text(message)
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.black)

                Button {
                    close()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.black)
                        NavigationLink(destination: HomeScreen()) {
                            Text(buttonTitle)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .foregroundColor(.white)
                                
                        }
                        .cornerRadius(20)
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding()
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(alignment: .topTrailing) {
                Button {
                    close()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                .tint(.black)
                .padding()
                
                
                
                
            }
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }
        }
        .ignoresSafeArea()
    }

    func close() {
        withAnimation(.spring()) {
            offset = 1000
            isActive = false
        }
    }
}

#Preview {
    FailureDialog(isActive: .constant(true))
}
