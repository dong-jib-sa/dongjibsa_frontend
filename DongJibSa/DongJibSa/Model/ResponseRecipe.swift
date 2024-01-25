//
//  ResponseRecipe.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/19.
//

import Foundation

struct ResponseRecipe: Codable {
    var resultCode: String
    var result: PostDto
}

struct PostDto: Codable {
    var includeCalorie: Bool
    var postDto: Recipe
}

struct Recipe: Codable {
    var id: Int
    var title: String
    var content: String
    var expectingPrice: Int
    var pricePerOne: Int
    var member: User?
    var recipeCalorie: ResponseRecipeCalorie?
    var peopleCount: Int
    var recipeIngredients: [ResponseRecipeIngredients]
    var imgUrls: [String]?
    var commentsCount: Int?
    var createdAt: String?
    var updatedAt: String?
}

struct ResponseRecipeIngredients: Codable {
    var id: Int
    var postId: Int
    var ingredientId: Int
    var ingredientName: String
    var totalQty: Double
    var requiredQty: Double
    var sharingAvailableQty: Double
}

struct ResponseRecipeCalorie: Codable {
    var id: Int
    var recipeName: String
    var calorie: Double
}

extension ResponseRecipe {
    init(from service: ResponseRecipe) {
        resultCode = service.resultCode
        result = service.result
    }
}

extension PostDto {
    init(from service: PostDto) {
        includeCalorie = service.includeCalorie
        postDto = service.postDto
    }
}
