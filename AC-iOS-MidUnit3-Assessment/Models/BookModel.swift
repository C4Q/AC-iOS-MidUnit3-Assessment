//
//  File.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Book: Codable {
    var items: [BookItems]
}
struct BookItems: Codable {
    var volumeInfo: Info
    var saleInfo: Sales
}
struct Info: Codable {
    var title: String
    var subtitle: String?
    var authors: [String]
    var description: String
    var imageLinks: Image
    var industryIdentifiers: [Identifier]
}
struct Image: Codable {
    var thumbnail: String
}
struct Identifier: Codable {
    var type: String
    var identifier: String
}
struct Sales: Codable {
    var retailPrice: Price
}
struct Price: Codable {
    var amount: Double
}
