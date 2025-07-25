//
//  TopDishes.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//

import SwiftUI

struct TopDishes: View {
    @StateObject private var viewModel: CuisineViewModel = CuisineViewModel()
    @EnvironmentObject var cartVM: CartViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            if viewModel.topDishes.isEmpty {
                ProgressView("Loading dishes...")
            } else {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.topDishes, id: \.1.id) { cuisineID,dish in
                        let quantity = cartVM.quantityForDish(itemID: dish.id)
                        VStack {
                            ZStack(alignment: .bottom){
                                RemoteImage(urlString: dish.image_url)
                                    .overlay(
                                        LinearGradient(
                                            gradient: Gradient(colors: [.clear, .black]),
                                            startPoint: .center,
                                            endPoint: .bottom
                                        ))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 115, height: 115)
                                    .clipped()
                                    .cornerRadius(10)
                                
                                Text(dish.name)
                                    .font(.body)
                                    .frame(maxWidth: .infinity)
                                    .lineLimit(1)
                                    .foregroundColor(.white)
                            }
                            HStack(spacing: 4) {
                                Text("₹\(dish.price)")
                                Spacer()
                                Text(dish.rating)
                                    .font(.system(size:15))
                                    .foregroundColor(.gray)
                                Image(systemName: "star.fill")
                                    .font(.system(size:15))
                                    .foregroundColor(.yellow)
                                
                            }
                            .padding(.horizontal,10)
                            .padding(.top,2)
                            
                            HStack(spacing: 12) {
                                if quantity>0{
                                    Button("-") {
                                        if cartVM.quantityForDish(itemID: dish.id) > 0 {
                                            cartVM.removeItem(dish: dish,cuisineID: cuisineID)
                                        }
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Text("\(quantity)")
                                    
                                    Button("+") {
                                        cartVM.addItem(dish: dish,cuisineID: cuisineID)
                                    }
                                    .buttonStyle(.plain)
                                }
                                else{
                                    Button("+ ADD") {
                                        cartVM.addItem(dish: dish,cuisineID: cuisineID)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            
                            .padding(.horizontal, 10)
                            .padding(.vertical, 1)
                            .background(.ultraThinMaterial)
                            .foregroundColor(.primary)
                            .clipShape(Capsule())
                            .shadow(radius: 3)
                            
                            
                        
                            
                        }
                        .padding(-1)
                        .padding(.bottom,5)
                        .frame(height: 200)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                }
                
                
            }
        }
        
        .onAppear {
            viewModel.fetchCuisinesIfNeeded()
        }
        .padding(.horizontal,10)
        
    }
}


#Preview {
    TopDishes().environmentObject(CartViewModel())
}
