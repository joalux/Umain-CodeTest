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
    var id: String
    let imageURL: String
    let filterIDS: [String]
    let deliveryTimeMinutes: Int
    let rating: Double
    let name: String
    var isOpen = false

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case imageURL = "image_url"
        case filterIDS = "filterIds"
        case deliveryTimeMinutes = "delivery_time_minutes"
        case rating, name
    }
    
    enum OpenKeys: String, CodingKey {
        case isOpen = "is_currently_open"
    }
        
}

