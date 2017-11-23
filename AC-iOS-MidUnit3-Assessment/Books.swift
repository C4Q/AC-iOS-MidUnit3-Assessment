//  Books.swift
//  AC-iOS-MidUnit3-Assessment
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

struct Items: Codable {
	let items: [Book]
}

struct Book: Codable {
	let volumeInfo: VolumeInfoWrapper
	let saleInfo: SaleInfoWrapper
	let searchInfo: SearchInfoWrapper
}

struct VolumeInfoWrapper: Codable {
	let title: String
	let authors: [String]
	let description: String //summary
	let industryIdentifiers: [IndustryIdentifiersWrapper]
	let imageLinks: ImageLinksWrapper
}

struct ImageLinksWrapper: Codable {
	let smallThumbnail: String
	let thumbnail: String
}

struct SaleInfoWrapper: Codable {
	let retailPrice: RetailPriceWrapper
}

struct RetailPriceWrapper: Codable {
	let amount: Double
}

struct IndustryIdentifiersWrapper: Codable {
	let identifier: String
}

struct SearchInfoWrapper: Codable {
	let textSnippet: String
}

