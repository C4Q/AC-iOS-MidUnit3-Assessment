//
//  Book.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


struct Book: Codable {
    let items: [Items]
}

struct Items: Codable {
    let kind: String
    let id: String
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let publisher: String
    let description: String
    let industryIdentifiers: [IndustryIdentifiers]
    let pageCount: Int
    let categories: [String]
    let imageLinks: ImageLinks
    
}

struct IndustryIdentifiers: Codable {
    let type: String
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}

struct SaleInfo: Codable {
    let listPrice: ListPrice
}

struct ListPrice: Codable {
    let amount: Double
    let currencyCode: String
}

