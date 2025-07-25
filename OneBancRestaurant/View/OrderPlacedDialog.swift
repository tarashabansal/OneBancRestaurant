//
//  OrderPlacedDialog.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/19/25.
//

import SwiftUI

struct OrderPlacedDialog: View {
    @Binding var isActive: Bool

    var title: String = "Order Placed!"
    var message: String = "Thankyou for using OneBanc Restaurant."
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
                    
                VStack{
                    Image(systemName: "hand.thumbsup.circle")
                        .font(.system(size: 80))
                        .foregroundColor(.black)
                    Text(message)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.black)
                }

                Button {
                    close()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            
                        NavigationLink(destination: HomeScreen()) {
                            Text(buttonTitle)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                
                        }
                        .cornerRadius(20)
                    }
                    .padding()
                }
            }
            .fixedSize(horizontal: false, vertical: true)
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
    OrderPlacedDialog(isActive: .constant(true))
}

