//
//  Jeopardy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Lisa J on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
struct JeopardyInfo :Codable {
    //if a value might be missing, make it optional
    let jeopardy: JeopardyWrapper
}
struct JeopardyWrapper: Codable {
    var category: CategoryWrapper
    let id: Int?
    let value: Int?
    let question: String?
    let answer: String?
}
struct CategoryWrapper: Codable {
    let title: String?
}
