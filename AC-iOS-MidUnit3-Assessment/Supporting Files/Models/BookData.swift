//
//  BookData.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Reiaz Gafar on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct BookCollection: Codable {
    var items: [Book]?
    
    static func getBookData() -> BookCollection {
        var books = BookCollection()
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    books = try myDecoder.decode(BookCollection.self, from: data)
                } catch let error {
                    print(error)
                }
            }
        }
        return books
    }
    
    
    
}

struct Book: Codable {
    var volumeInfo: VolumeInfo
    var saleInfo: PriceInfo
    
}

struct VolumeInfo: Codable {
    var title: String
    var subtitle: String?
    var authors: [String]
    var description: String
    var industryIdentifiers: [IndustryIdentifier]
    var imageLinks: ImageLink
}

struct IndustryIdentifier: Codable {
    var type: String
    var identifier: String
}

struct ImageLink: Codable {
    var thumbnail: String
}

struct PriceInfo: Codable {
    var listPrice: Price
}

struct Price: Codable {
    var amount: Double
}

