//
//  BookModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Clint Mejia on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct BookInfo: Codable {
    let items: [Volume]
}

struct Volume: Codable {
    let volumeInfo: Book
    let saleInfo: SalesDetails
}

struct Book: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let description: String?
}

struct SalesDetails: Codable {
    let listPrice: TotalPrice
}

struct TotalPrice: Codable {
    let amount: Double
}





/*
 VC - label: title, detail: price
 
 DVC - An image containining the default book image
book's name
book's subtitle (if available)
book's price
book's author
text view  -  book's summary
 
 Extra Credit opportunities:
 
label  - ISBN_13 code to your detail view controller
thumbnail instead of using the default image

 
 */
