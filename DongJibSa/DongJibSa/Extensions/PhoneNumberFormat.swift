//
//  PhoneNumberFormat.swift
//  DongJibSa
//
//  Created by heyji on 2023/10/27.
//

import UIKit

final class PhoneNumberFormat {
    private var digits: String = ""
    private let spacingString: Character = " "
    
    init(digits: String) {
        self.digits = digits
    }
    
    private func getDigitsWithoutSpacing(at number: String) -> String {
        return number.replacingOccurrences(of: "\(spacingString)", with: "")
    }
    
    public func addSpacing(at number: String) -> String {
        digits = getDigitsWithoutSpacing(at: number)
        guard digits.count > 2 else {
            return digits
        }
        switch digits.count {
        case 3:
            return digits
        case 4...7:
            digits.insert(spacingString, at: digits.getStringIndex(i: 3))
            return digits
        default:
            digits.insert(spacingString, at: digits.getStringIndex(i: 3))
            digits.insert(spacingString, at: digits.getStringIndex(i: 8))
            return digits
        }
    }
}
