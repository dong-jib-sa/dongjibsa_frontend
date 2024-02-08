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

extension Board {
    static let dummyDataList = [
        Board(id: 1, title: "애호박새우살볶음 파티원 모집", content: "애호박새우살볶음 파티원 모집", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 1, nickName: "집밥이지"), peopleCount: 3, recipeIngredients: [RecipeIngredients(ingredientName: "애호박", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "새우살", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "참기름", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "다진마늘", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2023/07/21/dc0f6123a2ebfd3aa8753a773d8b12521.jpg"]),
        Board(id: 2, title: "새송이버섯간장버터구이  해드실 분?", content: "새송이버섯간장버터구이  해드실 분?", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 1, nickName: "집밥이지"), peopleCount: 3, recipeIngredients: [RecipeIngredients(ingredientName: "새송이버섯", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "버터", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "어린잎채소", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2019/05/25/39ac1e73e998e88da300d38663242f0a1.jpg"]),
        Board(id: 3, title: "명란 마요 크래미 만들어 드실 분 모집", content: "명란 마요 크래미 만들어 드실 분 모집", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 1, nickName: "집밥이지"), peopleCount: 3, recipeIngredients: [RecipeIngredients(ingredientName: "유부초밥", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "크래미", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "참치", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "백명란", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2023/07/04/0226e6943bfbe1731472e00199eff61c1.jpg"]),
        Board(id: 4, title: "된장박이 재료 공구함", content: "된장박이 재료 공구함", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 1, nickName: "집밥이지"), peopleCount: 3, recipeIngredients: [RecipeIngredients(ingredientName: "풋고추", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "된장", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2015/04/22/a673e92121f268ea47ea5212bcbde4891.jpg"]),
        Board(id: 5, title: "떡 베이컨 간장조림 파티원 구해요~!", content: "떡 베이컨 간장조림 파티원 구해요~!", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 1, nickName: "집밥이지"), peopleCount: 3, recipeIngredients: [RecipeIngredients(ingredientName: "베이컨", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "대파", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "떡", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2016/02/16/d74c6731fce3dc72c5579b24083185f11.jpg"]),
        Board(id: 6, title: "명란 마요 크래미 만들어 드실 분 모집", content: "명란 마요 크래미 만들어 드실 분 모집", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 1, nickName: "집밥이지"), peopleCount: 3, recipeIngredients: [RecipeIngredients(ingredientName: "떡볶이떡", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), RecipeIngredients(ingredientName: "들기름", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2023/07/07/7fa82bf2d124346f6a14d8cc11faea771.jpg"]),
    ]
}
