//
//  Books.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct itemsWrapper: Codable {
    let items: [Book]
}

struct Book: Codable {
    let volumeInfo: InfoWrapper
    let saleInfo: SaleInfoWrapper
 
}
struct InfoWrapper: Codable {
    let title: String
    let authors: [String]
    let description: String
    let subtitle: String?
    let imageLinks: ImageWrapper
}

struct SaleInfoWrapper: Codable {
    let retailPrice: Price 
}

struct ImageWrapper: Codable {
    let thumbnail: String
}

struct Price: Codable {
    let amount: Double
    let currencyCode: String
}

