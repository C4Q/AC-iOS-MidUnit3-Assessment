//
//  TPBooksInfo.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Maryann Yin on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct PratchettBooks: Codable {
    let items: [BookInformation]
}

struct BookInformation: Codable {
    let volumeInfo: TitleInformation
    let saleInfo: PriceWrapper
}

struct TitleInformation: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let description: String
    let industryIdentifiers: [IndustryInfoWrapper]
    let imageLinks: ImageWrapper
}

struct IndustryInfoWrapper: Codable {
    let type: String
    let identifier: String
}

struct ImageWrapper: Codable {
    let smallThumbnail: String
    let thumbnail: String
}

struct PriceWrapper: Codable {
    let listPrice: PriceInUSDWrapper
}

struct PriceInUSDWrapper: Codable {
    let amount: Double
}
