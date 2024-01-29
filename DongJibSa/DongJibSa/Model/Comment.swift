//
//  Comment.swift
//  DongJibSa
//
//  Created by heyji on 2024/01/25.
//

import Foundation

struct Comment {
    var id: String
    var userName: String
    var comment: String
    var createdAt: String
    var reply: [Comment]
}
