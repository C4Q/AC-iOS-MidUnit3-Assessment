//
//  JeopardyDataModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Clint Mejia on 11/24/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Jeopardy: Codable {
    let answer: String
    let question: String
    let value: Int?
    let category: Category
}

struct Category: Codable {
    let title: String
}
