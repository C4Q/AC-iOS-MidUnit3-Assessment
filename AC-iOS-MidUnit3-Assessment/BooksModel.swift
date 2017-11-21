//
//  BooksModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Richard Crichlow on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct BooksTopLevel: Codable {
    var items: [BookInfo]
}

struct BookInfo: Codable {
    var volumeInfo: BooksWrapper
    var saleInfo: PriceWrapper
}

struct BooksWrapper: Codable {
    var title: String
    var subtitle: String?
    var authors: [String]
    var description: String //This is the summary
    var imageLinks: ImageWrapper
    var allAuthors: String {
    var authorString = ""
        for authors in authors {
            authorString.append(authors)
        }
    return authorString
    }
}

struct ImageWrapper: Codable {
    var smallThumbnail: String
    var thumbnail: String
}

struct PriceWrapper: Codable {
    var retailPrice: AmountWrapper
}

struct AmountWrapper: Codable {
    var amount: Double
}
