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
        MyPractice(item: "Discovery", description: "먹은 음식의 평균 칼로리", result: "0kcal"),
        MyPractice(item: "Chart", description: "버리지 않고 나눔한 식재료 수량", result: "0개")
    ]
}
