//
//  Indicator.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/05.
//

import Foundation

struct ResponseIndicator: Codable {
    var resultCode: String
    var result: Indicator
}

struct Indicator: Codable {
    var calorieAvg: Double
    var sumOfSharingAvailableQty: Double
}

extension ResponseIndicator {
    init(from service: ResponseIndicator) {
        resultCode = service.resultCode
        result = service.result
    }
}
