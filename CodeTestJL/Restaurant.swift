//
//  Resturant.swift
//  CodeTestJL
//
//  Created by joakim lundberg on 2022-10-06.
//

import Foundation
import SwiftUI

struct Restaurants: Codable {
    let restaurants: [Restaurant]
}

// MARK: - Restaurant
struct Restaurant: Codable, Hashable {
    //let id: String
    let imageURL: String
    let filterIDS: [String]
    let deliveryTimeMinutes: Int
    let rating: Double
    let name: String

    enum CodingKeys: String, CodingKey {
       // case id
        case imageURL = "image_url"
        case filterIDS = "filterIds"
        case deliveryTimeMinutes = "delivery_time_minutes"
        case rating, name
    }
}


/*
struct Response: Codable {
    var restaurants: [Restaurant]
    
}

struct Restaurant: Identifiable, Codable {
    
    var image_url: String
    var filterIds: [String]
    var filters: [String]
    var rating: Double
    var name: String
    var delivery_time_minutes: Int
    var id: String
    
}
*/
