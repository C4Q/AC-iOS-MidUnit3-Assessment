//
//  JeopardyInfo.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Maryann Yin on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct JeopardyMaterial: Codable {
    let id: Int // 89230
    let answer: String // "eggs"
    let question: String // "In an annual contest in Oatman, Arizona, folks try to fry these on the sidewalk with solar power"
    let value: Int? // 400
    let category: CategoryWrapper
}

struct CategoryWrapper: Codable {
    let id: Int //11759
    let title: String // "fun with science"
}
