//
//  LoginType.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/12.
//

import Foundation

enum LoginType: String, CaseIterable {
    case phoneNumber
    case kakao
    case apple
    
    var title: String {
        switch self {
        case .phoneNumber:
            return "phoneNumber"
        case .kakao:
            return "KAKAO"
        case .apple:
            return "APPLE"
        }
    }
}
