//
//  MenuListItem.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//

import SwiftUI

struct MenuListItem: View {
    let cuisineId: String
    let dish: Dish
    @EnvironmentObject var cartVM: CartViewModel
    var quantity: Int {
        cartVM.quantityForDish(itemID: dish.id)
    }
    var body: some View {
        HStack{
            VStack( alignment:.leading) {
                Text(dish.name)
                    .lineLimit(1)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text("₹\(dish.price)")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                HStack{
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("\(dish.rating)")
                }
            }
            Spacer()
            ZStack(alignment: .bottom) {
                RemoteImage(urlString: dish.image_url)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .cornerRadius(10)
                HStack(spacing: 12) {
                    Button("-") {
                        if cartVM.quantityForDish(itemID: dish.id) > 0 {
                            cartVM.removeItem(dish: dish,cuisineID: cuisineId)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Text("\(quantity)")
                    
                    Button("+") {
                        cartVM.addItem(dish: dish,cuisineID: cuisineId)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 10)
                .background(.ultraThinMaterial)
                .foregroundColor(.black)
                .clipShape(Capsule())
                .shadow(radius: 3)
                .offset(y: 5)
            }
            .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    MenuListItem(cuisineId:"234552", dish:Dish(id: "34234233",
                                               name: "Tandoori Chicken",
                                               image_url:"https://uat-static.onebanc.ai/picture/ob_dish_tandoori_chicken.webp",
                                               price: "250",
                                               rating: "4.7"))
    .environmentObject(CartViewModel())
}
