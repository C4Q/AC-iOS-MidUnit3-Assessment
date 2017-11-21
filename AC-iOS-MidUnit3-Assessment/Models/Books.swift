//
//  Books.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Books: Codable {
    let items: [Book]
}

struct Book: Codable{
    let volumeInfo: VolumeInfoWrapper
    let authors: String
    let description: String
    let industryIdentifiers: [ISBN]
    let imageLinks: ImageWrapper
    let retailPrice: PriceWrapper
    let searchInfo: SubtitleWrapper
    
}

struct VolumeInfoWrapper: Codable {
    let title: String
}

struct SubtitleWrapper: Codable {
    //subtitle
    let textSnippet: String
}

struct PriceWrapper: Codable {
    let amount: String
}

struct ImageWrapper: Codable{
    let smallThumbnail: String
    let thumbnail: String
}


struct ISBN: Codable{
    let type: String
    let identifier: String
}
