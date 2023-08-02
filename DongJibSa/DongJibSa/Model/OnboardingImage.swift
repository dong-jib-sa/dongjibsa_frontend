//
//  OnboardingImage.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/02.
//

import Foundation

struct Onboarding {
    var imageName: String
}

extension Onboarding {
    static let imageList: [Onboarding] = [
        Onboarding(imageName: "Image2"),
        Onboarding(imageName: "Image4"),
        Onboarding(imageName: "Image5"),
        Onboarding(imageName: "Image6")
    ]
}
