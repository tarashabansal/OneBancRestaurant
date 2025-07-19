//
//  CartItem.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/18/25.
//
import Foundation
import SwiftUI

struct CartItem: Identifiable, Equatable {
    let cuisineID: String
    let dishID: String
    let name: String
    let price: Int
    let imageURL: String
    var quantity: Int
    var id: String { dishID }
}
 
