//
//  Menu.swift
//  DongJibSa
//
//  Created by heyji on 2023/08/02.
//

import Foundation

struct Menu: Hashable {
    var name: String
    var imageName: String
}

extension Menu {
    static let menuList: [Menu] = [
        Menu(name: "한식", imageName: "Discovery"),
        Menu(name: "양식", imageName: "Discovery"),
        Menu(name: "중식", imageName: "Discovery"),
        Menu(name: "일식", imageName: "Discovery"),
        Menu(name: "분식", imageName: "Discovery"),
        Menu(name: "동남아식", imageName: "Discovery"),
        Menu(name: "퓨전한식", imageName: "Discovery"),
        Menu(name: "베트남식", imageName: "Discovery"),
        Menu(name: "간단식", imageName: "Discovery"),
        Menu(name: "디저트", imageName: "Discovery"),
    ]
}
