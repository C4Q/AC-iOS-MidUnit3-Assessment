//
//  BookModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct BookModel: Codable{
    let items : [Books]
}

struct Books: Codable {
    let volumeInfo: InfoWrapper
    let saleInfo: PriceWrapper
}

struct InfoWrapper: Codable{
    let title: String
    let subtitle: String?
    let authors: [String]
    let description: String
    let industryIdentifiers: [ISBN]
    let  imageLinks: ImageWrapper
}

struct ImageWrapper: Codable {
    var thumbnail: String
}

struct PriceWrapper: Codable {
    var retailPrice: RetailWrapper
}


struct RetailWrapper: Codable{
    var amount: Double
    var currencyCode: String
}


struct ISBN: Codable {
    var type: String
    var identifier: String
}

