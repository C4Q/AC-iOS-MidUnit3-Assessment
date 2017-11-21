//
//  Book.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Masai Young on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct BookAPIResponse: Codable {
    let items: [Item]
    let kind: String
    let totalItems: Int
    
    static func fetchUsers() -> BookAPIResponse? {
        
        var books: BookAPIResponse?
        
        guard let filePath = Bundle.main.path(forResource: "bookinfo", ofType: "json") else { return nil }
        let myUrl = URL(fileURLWithPath: filePath)
        if let data = try? Data(contentsOf: myUrl) {
            do {
                books = try JSONDecoder().decode(BookAPIResponse.self, from: data)
            } catch {
                print(error)
            }
        }
        return books
    }
    
}

struct Item: Codable {
    let accessInfo: AccessInfo
    let kind: String
    let saleInfo: SaleInfo
    let searchInfo: SearchInfo
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let allowAnonLogging: Bool
    let authors: [String]
    let averageRating: Double
    let canonicalVolumeLink: String
    let categories: [String]
    let contentVersion: String
    let description: String
    let imageLinks: ImageLinks
    let industryIdentifiers: [IndustryIdentifier]
    let infoLink: String
    let language: String
    let maturityRating: String
    let pageCount: Int
    let panelizationSummary: PanelizationSummary
    let previewLink: String
    let printType: String
    let publishedDate: String
    let publisher: String
    let ratingsCount: Int
    let readingModes: ReadingModes
    let subtitle: String?
    let title: String
}

struct ReadingModes: Codable {
    let image: Bool
    let text: Bool
}

struct PanelizationSummary: Codable {
    let containsEpubBubbles: Bool
    let containsImageBubbles: Bool
}

struct IndustryIdentifier: Codable {
    let identifier: String
    let type: String
}

struct ImageLinks: Codable {
    let smallThumbnail: String
    let thumbnail: String
}

struct SearchInfo: Codable {
    let textSnippet: String
}

struct SaleInfo: Codable {
    let buyLink: String
    let country: String
    let isEbook: Bool
    let listPrice: FluffyPrice
    let offers: [Offer]
    let retailPrice: FluffyPrice
    let saleability: String
}

struct Offer: Codable {
    let finskyOfferType: Int
    let giftable: Bool
    let listPrice: PurplePrice
    let retailPrice: PurplePrice
}

struct PurplePrice: Codable {
    let amountInMicros: Int
    let currencyCode: String
}

struct FluffyPrice: Codable {
    let amount: Double
    let currencyCode: String
}

struct AccessInfo: Codable {
    let accessViewStatus: String
    let country: String
    let embeddable: Bool
    let epub: Epub
    let pdf: Pdf
    let publicDomain: Bool
    let quoteSharingAllowed: Bool
    let textToSpeechPermission: String
    let viewability: String
    let webReaderLink: String
}

struct Pdf: Codable {
    let isAvailable: Bool
}

struct Epub: Codable {
    let acsTokenLink: String
    let isAvailable: Bool
}
