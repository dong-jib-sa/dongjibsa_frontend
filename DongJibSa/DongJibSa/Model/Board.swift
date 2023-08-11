//
//  Board.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/03.
//

import Foundation

struct Board: Codable {
    var title: String
    var content: String
    var userName: String
    var expectingPrice: Int
    var pricePerOne: Int
    var calorie: Double?
    var peopleCount: Int
    var recipeIngredients: [RecipeIngredients]
    var imgUrl: String
    var commentsCount: Int?
}

struct RecipeIngredients: Codable {
    var ingredientName: String
    var totalQty: Double
    var requiredQty: Double
    var sharingAvailableQty: Double
}
