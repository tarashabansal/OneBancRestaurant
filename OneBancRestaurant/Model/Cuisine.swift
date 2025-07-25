//
//  Cuisine.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//

struct Cuisine: Identifiable, Decodable {
    let cuisine_id: String
    let cuisine_name: String
    let cuisine_image_url: String
    let items: [Dish]
    var id: String { cuisine_id }
}
//output format for get_item_by_list API
struct ItemListResponse: Decodable {
    let cuisines: [Cuisine]
}
