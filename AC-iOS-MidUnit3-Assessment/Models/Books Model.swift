//
//  Books Model.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 12/4/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
import Foundation

struct Books: Codable {
    let items: [Items]
}

struct Items: Codable {
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}

struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let description: String
    let imageLinks: ImageLinks
}

struct ImageLinks: Codable {
    let thumbnail: String
}

struct SaleInfo: Codable {
    let listPrice: ListPrice
}

struct ListPrice: Codable {
    let amount: Double
}
