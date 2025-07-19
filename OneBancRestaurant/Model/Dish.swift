//
//  Dish.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//


struct Dish: Identifiable, Decodable {
    let id: String
    let name: String
    let image_url: String
    let price: String
    let rating: String
}

