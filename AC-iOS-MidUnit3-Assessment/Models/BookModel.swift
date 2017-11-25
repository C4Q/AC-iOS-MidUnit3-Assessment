//
//  BookModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Clint Mejia on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct BookInfo: Codable {
    let items: [Volume]
}

struct Volume: Codable {
    let volumeInfo: Book
    let saleInfo: SalesDetails
}

struct Book: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let description: String?
    let industryIdentifiers: [ISBN]
    let imageLinks : Images
}

struct SalesDetails: Codable {
    let listPrice: TotalPrice
}

struct TotalPrice: Codable {
    let amount: Double
}

struct ISBN: Codable {
    let type: String
    let identifier: String
}

struct Images: Codable {
    let smallThumbnail: String
    let thumbnail: String
}
