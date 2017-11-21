//
//  BookModel.swift
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
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

struct VolumeInfo: Codable {
    let title: String?
    let subtitle: String?
    let authors: [String]
    let description: String
}

struct SaleInfo: Codable {
    let listPrice: PriceDict
}

struct PriceDict: Codable {
    let amount: Double
}



