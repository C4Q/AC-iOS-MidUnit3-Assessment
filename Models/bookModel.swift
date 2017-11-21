//
//  bookModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct BookJSONTop: Codable {
    var items: [ItemWrapper]
}

struct ItemWrapper: Codable {
    var volumeInfo: VolumeWrapper
    var saleInfo: SaleInfoWrapper
}

struct VolumeWrapper: Codable {
    var title: String
    var subtitle: String?
    var authors: [String]
    var description: String     // summary
    var industryIdentifiers: [IndustryIdentifiersWrapper]
    var imageLinks: ImageLinksWrapper
}

struct IndustryIdentifiersWrapper: Codable {
    var type: String
    var identifier: String
}

struct ImageLinksWrapper: Codable {
    var thumbnail: String
}

struct SaleInfoWrapper: Codable {
    var retailPrice: RetailPriceWrapper
}

struct RetailPriceWrapper: Codable {
    var amount: Double
}
