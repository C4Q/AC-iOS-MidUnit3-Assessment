//
//  Jeapordy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Ashlee Krammer on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct Jeopardy: Codable {
    var answer: String
    var question: String
    var value: Int?
    var category: CategoryWrapper
    
}

struct CategoryWrapper: Codable {
    var title: String
}








