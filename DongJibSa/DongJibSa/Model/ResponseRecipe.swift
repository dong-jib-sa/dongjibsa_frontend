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

extension PostDto {
    static let dummyDataList = [
        PostDto(includeCalorie: true, postDto: Recipe(id: 1, title: "애호박새우살볶음 파티원 모집", content: "애호박새우살볶음 파티원을 모집합니다. 오늘 저녁은 애호박새우살볶음으로 어떠신가요? 퇴근하면서 같이 장봐요", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 1, nickName: "집밥이지"), recipeCalorie: ResponseRecipeCalorie(id: 1, recipeName: "애호박새우살볶음", calorie: 234.0), peopleCount: 3, recipeIngredients: [ResponseRecipeIngredients(id: 1, postId: 1, ingredientId: 1, ingredientName: "애호박", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 2, postId: 1, ingredientId: 2, ingredientName: "새우살", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 3, postId: 1, ingredientId: 3, ingredientName: "참기름", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 4, postId: 1, ingredientId: 4, ingredientName: "다진마늘", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2023/07/21/dc0f6123a2ebfd3aa8753a773d8b12521.jpg"], commentsCount: 0, createdAt: "2024-01-19T13:46:39.097523", updatedAt: "2024-01-19T13:46:39.097523")),
        PostDto(includeCalorie: true, postDto: Recipe(id: 2, title: "새송이버섯간장버터구이  해드실 분?", content: "새송이버섯간장버터구이 해드실 분?", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 2, nickName: "성실한 곰"), recipeCalorie: ResponseRecipeCalorie(id: 2, recipeName: "새송이버섯간장버터구이", calorie: 234.0), peopleCount: 2, recipeIngredients: [ResponseRecipeIngredients(id: 1, postId: 2, ingredientId: 1, ingredientName: "새송이버섯", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 2, postId: 2, ingredientId: 2, ingredientName: "버터", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 3, postId: 2, ingredientId: 3, ingredientName: "어린잎채소", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2019/05/25/39ac1e73e998e88da300d38663242f0a1.jpg"], commentsCount: 0, createdAt: "2024-01-25T13:46:39.097523", updatedAt: "2024-01-25T13:46:39.097523")),
        PostDto(includeCalorie: true, postDto: Recipe(id: 3, title: "명란 마요 크래미 만들어 드실 분 모집", content: "명란 마요 크래미 만들어 드실 분 모집", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 2, nickName: "성실한 곰"), recipeCalorie: ResponseRecipeCalorie(id: 3, recipeName: "명란 마요 크래미", calorie: 234.0), peopleCount: 4, recipeIngredients: [ResponseRecipeIngredients(id: 1, postId: 3, ingredientId: 1, ingredientName: "유부초밥", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 2, postId: 3, ingredientId: 2, ingredientName: "크래미", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 3, postId: 3, ingredientId: 3, ingredientName: "참치", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 3, postId: 3, ingredientId: 3, ingredientName: "백명란", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2023/07/04/0226e6943bfbe1731472e00199eff61c1.jpg"], commentsCount: 0, createdAt: "2024-01-25T13:46:39.097523", updatedAt: "2024-01-25T13:46:39.097523")),
        PostDto(includeCalorie: true, postDto: Recipe(id: 4, title: "된장박이 재료 공구함", content: "된장박이 재료 공구함", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 2, nickName: "성실한 곰"), recipeCalorie: ResponseRecipeCalorie(id: 4, recipeName: "된장박이 재료 공구함", calorie: 234.0), peopleCount: 2, recipeIngredients: [ResponseRecipeIngredients(id: 1, postId: 4, ingredientId: 1, ingredientName: "풋고추", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 2, postId: 4, ingredientId: 2, ingredientName: "된장", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2015/04/22/a673e92121f268ea47ea5212bcbde4891.jpg"], commentsCount: 0, createdAt: "2024-01-25T13:46:39.097523", updatedAt: "2024-01-25T13:46:39.097523")),
        PostDto(includeCalorie: true, postDto: Recipe(id: 5, title: "떡 베이컨 간장조림 파티원 구해요~!", content: "떡 베이컨 간장조림 파티원 구해요~!", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 2, nickName: "성실한 곰"), recipeCalorie: ResponseRecipeCalorie(id: 5, recipeName: "떡 베이컨 간장조림", calorie: 234.0), peopleCount: 3, recipeIngredients: [ResponseRecipeIngredients(id: 1, postId: 5, ingredientId: 1, ingredientName: "베이컨", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 2, postId: 5, ingredientId: 2, ingredientName: "대파", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 3, postId: 5, ingredientId: 3, ingredientName: "떡", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2016/02/16/d74c6731fce3dc72c5579b24083185f11.jpg"], commentsCount: 0, createdAt: "2024-02-05T13:46:39.097523", updatedAt: "2024-02-05T13:46:39.097523")),
        PostDto(includeCalorie: true, postDto: Recipe(id: 6, title: "떡볶이 만들어 드실 파티원 구해요~!", content: "떡볶이 만들어 드실 파티원 구해요~!", expectingPrice: 4500, pricePerOne: 2000, member: User(id: 1, nickName: "집밥이지"), recipeCalorie: ResponseRecipeCalorie(id: 6, recipeName: "떡볶이", calorie: 234.0), peopleCount: 4, recipeIngredients: [ResponseRecipeIngredients(id: 1, postId: 6, ingredientId: 1, ingredientName: "떡볶이떡", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0), ResponseRecipeIngredients(id: 2, postId: 6, ingredientId: 2, ingredientName: "들기름", totalQty: 3.0, requiredQty: 1.0, sharingAvailableQty: 2.0)], imgUrls: ["https://recipe1.ezmember.co.kr/cache/recipe/2023/07/07/7fa82bf2d124346f6a14d8cc11faea771.jpg"], commentsCount: 0, createdAt: "2024-02-05T13:46:39.097523", updatedAt: "2024-02-05T13:46:39.097523")),
    ]
}
