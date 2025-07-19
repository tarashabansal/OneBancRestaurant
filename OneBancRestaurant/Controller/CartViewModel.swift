//
//  CartViewModel.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//


import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    

    @Published var items: [CartItem] = []
    //total for all the items in cart
    var netTotal: Int {
        items.reduce(0) { $0 + ($1.price * $1.quantity) }
    }
    //2.5% CGST calculation
    var cgst: Double {
        Double(netTotal) * 0.025
    }
    //2.5% SGST calculation
    var sgst: Double {
        Double(netTotal) * 0.025
    }
    //cnetTotal + Taxes
    var grandTotal: Double {
        Double(netTotal) + cgst + sgst
    }
    // Number of itmes in cart
    var totalItems: Int {
        items.reduce(0) { $0 + ($1.quantity) }
    }

    func addItem(dish: Dish, cuisineID: String) {
        if let index = items.firstIndex(where: { $0.dishID == dish.id }) {
            items[index].quantity += 1
        }
        else{
            // If not found in cart, add as new item
            let newItem = CartItem(
                cuisineID: cuisineID,
                dishID: dish.id,
                name: dish.name,
                price: Int(dish.price) ?? 0,
                imageURL: dish.image_url,
                quantity: 1
            )
            items.append(newItem)
        }
    }
    
    func addItem(_ item:CartItem) {
        print(item)
        if let index = items.firstIndex(where: { $0.dishID == item.dishID }) {
            items[index].quantity += 1
        }
    }

    func removeItem(dish: Dish, cuisineID: String) {
        if let index = items.firstIndex(where: { $0.dishID == dish.id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
        }
    }
    
    func removeItem(_ item: CartItem) {
        if let index = items.firstIndex(where: { $0.dishID == item.dishID }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
        }
    }

    func clearCart() {
        items.removeAll()
    }
    
    func quantityForDish(itemID: String) -> Int {
        return items.first(where: { $0.dishID == itemID })?.quantity ?? 0
    }
    
    func makePayment(completion: @escaping (Int) -> Void) {
        let paymentItems = items.map {
            PaymentItem(
                cuisine_id: $0.cuisineID,
                item_id: $0.dishID,
                item_price: $0.price,
                item_quantity: $0.quantity
            )
        }
        
        let body = PaymentRequest(
            total_amount: "\(grandTotal)",
            total_items: totalItems,
            data: paymentItems
        )
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let jsonData = try encoder.encode(body)
            make_payment_API(body: jsonData) { responseCode in
                completion(responseCode)
            }
        } catch {
            print("Failed to encode PaymentRequest into JSON: \(error)")
            completion(400)
        }
    }

    
    func make_payment_API(body: Data, completion: @escaping (Int) -> Void) {
        let API_ENDPOINT = "make_payment"
        guard let url = URL(string: "https://uat.onebanc.ai/emulator/interview/\(API_ENDPOINT)") else {
            completion(400)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("uonebancservceemultrS3cg8RaL30", forHTTPHeaderField: "X-Partner-API-Key")
        request.addValue(API_ENDPOINT, forHTTPHeaderField: "X-Forward-Proxy-Action")
        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print("No data or network error:", error ?? "Unknown error")
                completion(400)
                return
            }

            do {
                let result = try JSONDecoder().decode(PaymentResponse.self, from: data)
                DispatchQueue.main.async {
                    if result.response_code == 200 {
                        self.clearCart()
                    }
                    completion(result.response_code)
                }
            } catch {
                print("Decoding error:", error)
                completion(400)
            }
        }.resume()
    }
    
    
    //Toolbar Cart Button UI
    struct CartButton: View {
        @EnvironmentObject var cartVM: CartViewModel
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                NavigationLink(destination: Cart()) {
                    Image(systemName: "cart")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 28, height: 28)
                        .padding()
                }
                
                if cartVM.totalItems > 0 {
                    Text("\(cartVM.totalItems)")
                        .font(.caption2)
                        .foregroundColor(.black)
                        .padding(6)
                        .background(Color.yellow)
                        .clipShape(Circle())
                        .offset(x:-7, y:10)
                    
                }
            }
        }
    }
}
