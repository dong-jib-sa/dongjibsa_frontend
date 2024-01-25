//
//  Board.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/03.
//

import Foundation

struct ResultData: Decodable {
    var resultCode: String
    var result: [Board]
}

struct Board: Codable {
    var id: Int
    var title: String
    var content: String
    var expectingPrice: Int
    var pricePerOne: Int
    var member: User?
    var recipeCalorie: RecipeCalorie?
    var peopleCount: Int
    var recipeIngredients: [RecipeIngredients]
    var imgUrls: [String]?
    var commentsCount: Int?
    var createdAt: String?
    var updatedAt: String?
}

struct RecipeIngredients: Codable {
    var id: Int?
    var postId: Int?
    var ingredientId: Int?
    var ingredientName: String
    var totalQty: Double
    var requiredQty: Double
    var sharingAvailableQty: Double
}

struct RecipeCalorie: Codable {
    var id: Int
    var recipeName: String
    var calorie: Double?
}

extension ResultData {
    init(from service: ResultData) {
        resultCode = service.resultCode
        result = []
        
        for board in service.result {
            result.append(board)
        }
    }
}
