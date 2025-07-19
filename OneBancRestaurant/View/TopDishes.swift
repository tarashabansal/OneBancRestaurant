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
                            RemoteImage(urlString: dish.image_url)
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Text(dish.name)
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                                .lineLimit(1)
                            HStack(spacing: 4) {
                                Text("₹\(dish.price)")
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                                Text(dish.rating)
                                    .foregroundColor(.gray)
                            }
                            
                            HStack(spacing: 12) {
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
                        }
                        .padding(-1)
                        .frame(height: 200)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                    }
                }
                .padding(0)
                
            }
        }
        .onAppear {
            viewModel.fetchCuisinesIfNeeded()
        }
    }
}


#Preview {
    TopDishes().environmentObject(CartViewModel())
}
