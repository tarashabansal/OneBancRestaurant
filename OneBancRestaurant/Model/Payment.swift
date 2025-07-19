//
//  Payment.swift
//  OneBancRestaurant
//
//  Created by Tarasha Bansal on 7/19/25.
//
//input format for data in make_payment API
struct PaymentItem: Codable {
    let cuisine_id: String
    let item_id: String
    let item_price: Int
    let item_quantity: Int
}
//input format for make_payment API
struct PaymentRequest: Codable{
    let total_amount: String
    let total_items: Int
    let data: [PaymentItem]
}
//output format for make_payment API
struct PaymentResponse: Codable  {
    let response_code: Int
    let outcome_code: Int
    let response_message: String
    let txn_ref_no: String
}
