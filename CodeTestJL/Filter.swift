//
//  Filter.swift
//  CodeTestJL
//
//  Created by joakim lundberg on 2022-10-07.
//

import Foundation

struct Filter: Hashable, Identifiable, Codable {
    let id: String
    let name: String
    let image_url: String
}
