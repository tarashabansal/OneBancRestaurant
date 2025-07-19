//
//  CuisineViewModel.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//


import Foundation

class CuisineViewModel: ObservableObject {
    @Published var cuisines: [Cuisine] = []
    @Published var topDishes: [(String,Dish)] = []

    func fetchCuisinesIfNeeded() {
        if cuisines.isEmpty{
            fetchCuisines()
        }
    }
    func fetchCuisines() {
        let API_ENDPOINT="get_item_list"
        guard let url = URL(string: "https://uat.onebanc.ai/emulator/interview/\(API_ENDPOINT)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("uonebancservceemultrS3cg8RaL30", forHTTPHeaderField: "X-Partner-API-Key")
        request.addValue(API_ENDPOINT, forHTTPHeaderField: "X-Forward-Proxy-Action")
        
        //Sample Input : Can be changed as per required
        let body: [String: Any] = ["page": 2, "count": 20]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                if String(data: data, encoding: .utf8) != nil {

                }
                do {
                    let result = try JSONDecoder().decode(ItemListResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.cuisines = result.cuisines
                        let allItemsWithCuisineID: [(String, Dish)] = self.cuisines.flatMap { cuisine in
                            cuisine.items.map { dish in
                                (cuisine.cuisine_id, dish)
                            }
                        }
                        let sorted = allItemsWithCuisineID.sorted {
                            (Float($0.1.rating) ?? 0) > (Float($1.1.rating) ?? 0)
                        }
                        self.topDishes = Array(sorted.prefix(3))
                    }
                } catch {
                    print("Decoding error:", error)
                }
            } else {
                print("No data or network error:", error ?? "Unknown error")
            }
        }.resume()
    }
}



