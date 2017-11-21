//
//  Books.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Books: Codable {
    let items: [ItemsWrapper]
}

struct ItemsWrapper: Codable {
    let volumeInfo: VolumeInfoWrapper
    let saleInfo: SaleInfoWrapper
    let searchInfo: SubtitleWrapper
}

struct VolumeInfoWrapper: Codable {
    let title: String
    let description: String?
    let authors: [String]
    let imageLinks: ImageLinkWrapper
}

struct SaleInfoWrapper: Codable {
    let retailPrice: RetailPriceWrapper
}

struct RetailPriceWrapper: Codable {
    let amount: Double
}

struct ImageLinkWrapper: Codable {
    let smallThumbnail: String
    let thumbnail: String
}

struct SubtitleWrapper: Codable {
    let textSnippet: String
}
