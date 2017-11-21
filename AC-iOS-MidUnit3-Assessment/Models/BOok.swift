//
//  Book.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Luis Calle on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct AllBooks: Codable {
    let items: [Book]
}

struct Book: Codable {
    let volumeInfo: VolumeInfoWrapper
    let saleInfo: SaleInfoWrapper
}

struct VolumeInfoWrapper: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let description: String
    let imageLinks: ImagesWrapper
}

struct ImagesWrapper: Codable {
    let smallThumbnail: String
    let thumbnail: String
}

struct SaleInfoWrapper: Codable {
    let retailPrice: PriceWrapper
}

struct PriceWrapper: Codable {
    let amount: Double
}
