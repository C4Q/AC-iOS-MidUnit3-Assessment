//
//  Jeopardy Model.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
import Foundation

struct Jeopardy: Codable {
    var answer: String
    var question: String
    var value: Int?
    var category: Category
}
struct Category: Codable {
    var title: String
}
