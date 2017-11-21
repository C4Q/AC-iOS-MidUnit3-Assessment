//
//  Jepoardy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct JeopardyInfo: Codable{
    let answer: String
    let question: String
    let value: Int?
    let category: CategoryWrapper
    
}

struct CategoryWrapper: Codable{
    let title: String
}

class JeopardyQuestion{

    
   
}
