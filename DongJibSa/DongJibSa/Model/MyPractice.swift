//
//  MyPractice.swift
//  DongJibSa
//
//  Created by heyji on 2023/07/30.
//

import Foundation

struct MyPractice: Hashable {
    var item: String
    var description: String
    var result: String
}

extension MyPractice {
    static let list = [
        MyPractice(item: "Discovery", description: "이번주 내가 먹은\n음식의 총 칼로리", result: "0000kcal"),
        MyPractice(item: "Chart", description: "이번주 내가 버리지 않고\n나눔한 식재료 수량", result: "0000개")
    ]
}
