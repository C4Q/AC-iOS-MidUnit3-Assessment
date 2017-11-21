//
//  Book.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Lisa J on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct ItemWrapper :Codable {
    let items:[Book]
}
struct Book: Codable {
 
    let volumeInfo : VolumeWrapper
    let saleInfo : SaleInfoWrapper
}
struct VolumeWrapper: Codable {
    let imageLinks: ImageWrapper
    let subtitle: String?
     let title: String
    let authors: [String]
    let description: String

}
struct SaleInfoWrapper:Codable {
    let listPrice: AmountWrapper
    
}


struct AmountWrapper: Codable {
    let amount: Double
}
struct ImageWrapper: Codable {
    let thumbnail: String
}
