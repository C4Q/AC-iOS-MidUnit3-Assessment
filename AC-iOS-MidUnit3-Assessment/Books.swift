//
//  Books.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Ashlee Krammer on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Books: Codable {
    var items: [ItemsWrapper]
}

struct ItemsWrapper: Codable {
    var title: String?
    var description: String?
    var authors: [String]
}

//struct AuthorWrapper: Codable {
//    var authors: [String]
//}


//{
//    "kind": "books#volumes",
//    "totalItems": 2308,
//    "items": [
//    {
//    "kind": "books#volume",
//    "id": "UN1RKjs6E8YC",
//    "etag": "p4gBW50aAxQ",
//    "selfLink": "https://www.googleapis.com/books/v1/volumes/UN1RKjs6E8YC",
//    "volumeInfo": {
//    "title": "Nation",
//    "authors": [
//    "Terry Pratchett"
//    ],
//    "publisher": "Harper Collins",
//    "publishedDate": "2009-10-06",
//    "description": "When a giant wave destroys his village, Mau is the only one left. Daphne—a traveler from the other side of the globe—is the sole survivor of a shipwreck. Separated by language and customs, the two are united by catastrophe. Slowly, they are joined by other refugees. And as they struggle to protect the small band, Mau and Daphne defy ancestral spirits, challenge death himself, and uncover a long-hidden secret that literally turns the world upside down.",
//    "industryIdentifiers": [
//    {
//    "type": "ISBN_13",
//    "identifier": "9780061975233"
//    },
//    {
//    "type": "ISBN_10",
//    "identifier": "0061975230"
//    }
//    ],
//    "readingModes": {
//    "text": true,
//    "image": false
//    },

