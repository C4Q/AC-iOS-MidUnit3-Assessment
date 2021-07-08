//
//  Books.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Books: Codable {
    let items: [BookInfo]
    
}


struct BookInfo: Codable {
    let volumeInfo: VolumeInfo
    let saleInfo: SaleInfo
}


struct VolumeInfo: Codable {
let title: String
let subtitle: String?
let authors: [String]
let description: String
//let imageLinks: Pictures
//let industryIdentifiers: IndustryIdentifiers
}


//struct Pictures: Codable {
//    let thumbnail: String
//    let smallThumbnail: String
//}


//struct IndustryIdentifiers: Codable {
//    let type: String  //do if type = ISBN_13
//    let identifier: String
//}


struct SaleInfo: Codable {
    let retailPrice: Amount
}


struct Amount: Codable {
    let amount: Double
}



/*
 
 
 {
 "kind": "books#volumes",
 "totalItems": 2308,
 "items": [
 {
 "kind": "books#volume",
 "id": "UN1RKjs6E8YC",
 "etag": "p4gBW50aAxQ",
 "selfLink": "https://www.googleapis.com/books/v1/volumes/UN1RKjs6E8YC",
 "volumeInfo": {
 "title": "Nation",
 "authors": [
 "Terry Pratchett"
 ],
 "publisher": "Harper Collins",
 "publishedDate": "2009-10-06",
 "description": "When a giant wave destroys his village, Mau is the only one left. Daphne—a traveler from the other side of the globe—is the sole survivor of a shipwreck. Separated by language and customs, the two are united by catastrophe. Slowly, they are joined by other refugees. And as they struggle to protect the small band, Mau and Daphne defy ancestral spirits, challenge death himself, and uncover a long-hidden secret that literally turns the world upside down.",
 "industryIdentifiers": [
 {
 "type": "ISBN_13",
 "identifier": "9780061975233"
 },
 {
 "type": "ISBN_10",
 "identifier": "0061975230"
 }
 ],
 "readingModes": {
 "text": true,
 "image": false
 },
 "pageCount": 384,
 "printType": "BOOK",
 "categories": [
 "Young Adult Fiction"
 ],
 "averageRating": 4.0,
 "ratingsCount": 120,
 "maturityRating": "NOT_MATURE",
 "allowAnonLogging": true,
 "contentVersion": "1.7.6.0.preview.2",
 "panelizationSummary": {
 "containsEpubBubbles": false,
 "containsImageBubbles": false
 },
 "imageLinks": {
 "smallThumbnail": "http://books.google.com/books/content?id=UN1RKjs6E8YC&printsec=frontcover&img=1&zoom=5&edge=curl&source=gbs_api",
 "thumbnail": "http://books.google.com/books/content?id=UN1RKjs6E8YC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api"
 },
 "language": "en",
 "previewLink": "http://books.google.com/books?id=UN1RKjs6E8YC&pg=PP1&dq=Pratchett&hl=&cd=1&source=gbs_api",
 "infoLink": "https://play.google.com/store/books/details?id=UN1RKjs6E8YC&source=gbs_api",
 "canonicalVolumeLink": "https://market.android.com/details?id=book-UN1RKjs6E8YC"
 },
 "saleInfo": {
 "country": "US",
 "saleability": "FOR_SALE",
 "isEbook": true,
 "listPrice": {
 "amount": 1.99,
 "currencyCode": "USD"
 },
 "retailPrice": {
 "amount": 1.99,
 "currencyCode": "USD"
 },
 "buyLink": "https://play.google.com/store/books/details?id=UN1RKjs6E8YC&rdid=book-UN1RKjs6E8YC&rdot=1&source=gbs_api",
 "offers": [
 {
 "finskyOfferType": 1,
 "listPrice": {
 "amountInMicros": 1990000.0,
 "currencyCode": "USD"
 },
 "retailPrice": {
 "amountInMicros": 1990000.0,
 "currencyCode": "USD"
 },
 "giftable": true
 }
 ]
 },
 "accessInfo": {
 "country": "US",
 "viewability": "PARTIAL",
 "embeddable": true,
 "publicDomain": false,
 "textToSpeechPermission": "ALLOWED_FOR_ACCESSIBILITY",
 "epub": {
 "isAvailable": true,
 "acsTokenLink": "http://books.google.com/books/download/Nation-sample-epub.acsm?id=UN1RKjs6E8YC&format=epub&output=acs4_fulfillment_token&dl_type=sample&source=gbs_api"
 },
 "pdf": {
 "isAvailable": false
 },
 "webReaderLink": "http://play.google.com/books/reader?id=UN1RKjs6E8YC&hl=&printsec=frontcover&source=gbs_api",
 "accessViewStatus": "SAMPLE",
 "quoteSharingAllowed": false
 },
 "searchInfo": {
 "textSnippet": "When a giant wave destroys his village, Mau is the only one left."
 }
 },
 JSON Source:
 
 Google Books API
 
 Notes
 
 The subtitle is sometimes absent. Be sure to still make a book even if it doesn't have a subtitle.
 Requirements:
 
 The View Controller of your Tab Bar Controller should be a Navigation Controller. The root of your Navigation Controller should be a View Controller with a table view inside. Selecting a row in your table view should segue to a View Controller with additional details.
 
 Table View
 
 It's fine to user a default table view cell
 The textLabel of each cell should be the book's title
 The detailTextLabel of each cell should be the book's price
 Detail View Controller
 
 Your Detail View Controller should include:
 
 An image containining the default book image
 A text label with the book's name
 A text label with the book's subtitle (if available)
 A text label with the book's price
 A text label with the book's author
 A text view with the book's summary
 Extra Credit opportunities:
 
 Add a text label with the ISBN_13 code to your detail view controller
 Load the actual book thumbnail instead of using the default image
 */
