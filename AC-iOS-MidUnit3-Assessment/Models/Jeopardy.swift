//
//  Jeopardy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct Jeopardy: Codable {
//    let id: Int
    let answer: String
    let question: String
    let value: Int?
    let category: Category
}

struct Category: Codable {
//    let id: Int
    let title: String
    let clues_count: Int
}

