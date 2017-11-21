//
//  googleBooksModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

struct BookItems: Codable {
    let items: [Book]
}

struct Book: Codable {
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let description: String
    let imageLinks: Images
    
}

struct SaleInfo: Codable {
    let retailPrice: RetailPrice
}

struct RetailPrice: Codable {
    let amount: Double
}

struct Images: Codable {
    var thumbnail: String
}


class ParsedJSON {
    static func getBook() -> [Book] {
        var books = [Book]()
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                do {
                    let bookItems = try JSONDecoder().decode(BookItems.self, from: data)
                    books = bookItems.items.sorted { $0.volumeInfo.title < $1.volumeInfo.title }
                }
                catch {
                    print(error)
                }
            }
        }
        return books
    }
}







