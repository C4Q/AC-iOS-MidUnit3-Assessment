//
//  BookModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct Items: Codable {
    let books: [Book]
}
struct Book: Codable {
    let title: String
    let listPrice: Double
    let subtitle: String?
    let authors: [String]
    let summary: String
    
    
}
