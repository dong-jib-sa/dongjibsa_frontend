//
//  User.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/15.
//

import Foundation

struct User: Codable {
    var id: Int
    var nickName: String
    var email: String?
    var phoneNumber: String?
    var calorieAvg: Double
    var totalSharingNum: Int
    var totalSharingNumPerRecipe: Int?
    var socialId: String?
    var socialType: String?
    var createdAt: String?
    var updatedAt: String?
}
