//
//  ModelRecipte.swift
//  Uikit_Menu_14_03_2023
//
//  Created by Denis Orlenko on 14.03.2023.
//


import UIKit

struct Reciptes: Decodable {
    var results: [Recipe]
}

struct Recipe: Identifiable, Decodable{
    var id: Int
    var title: String
    var rating: Int
    var ingredients: [String]
    var featured_image: URL
    var select: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id = "pk"
        case title = "title"
        case rating = "rating"
        case ingredients
        case featured_image = "featured_image"
    }
}
