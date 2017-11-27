//
//  Books.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Ashlee Krammer on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation






//class Books {
//
//    //Creating a model for a question 
//    var title: String
//    var authors: [String]
//    var subtitle: String?
//    var description: String
//    var price: Double
//
//
//    init(title: String, authors: [String], subtitle: String?, description: String, price: Double) {
//        self.title = title
//        self.authors = authors
//        self.subtitle = subtitle
//        self.description = description
//        self.price = price
//    }
//    
//    
//    convenience init?(from dict: [String:Any]) {
//        let title = dict["title"] as? String ?? "No Title"
//        let authors = dict["authors"] as? [String] ?? ["Unknown Author"]
//        let subtitle = dict["subtitle"] as? String ?? "No Subtitle"
//        let description = dict["description"] as? String ?? "No Description"
//        let price = dict["price"] as? Double ?? 0.0
//        
//        self.init(title: title, authors: authors, subtitle: subtitle, description: description, price: price)
//        
//    }
//    
//    
//    static func getBooks(from data: Data) -> [Books] {
//        var bookArr = [Books]()
//        
//        
//        //This is like a big if else where you must have an else that is a catch
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            guard let jsonDict = json as? [String: Any] else { return [] }
//            let jsonMain = jsonDict["items"] as? [[String: Any]]
//           
//            for element in jsonMain!{
//                if let books = Books.init(from: (element["volumeInfo"] as? [String:Any])!){
//                    bookArr.append(books)
//                }
//            }
////            let jsonArr = jsonMain!["volumeInfo"] as? [[String:Any]]
//            
//            
//            
//            //Iterating through the array of dictionarys  then appending to an array
////            for bookDict in jsonArr! {
////                if let books = Books(from: bookDict) {
////
////                    bookArr.append(books)
////
////                     dump(bookArr)
////                }
////
////            }
//            
//        }
//        catch {
//            print(error)
//        }
//        
//        return bookArr
//    }
//    
//    
//    
//}

struct BookModel: Codable {
    var items: [Books]
}

struct Books: Codable {
    var volumeInfo: InfoWrapper
    var saleInfo: PriceWrapper
 
}

struct InfoWrapper: Codable {
    var title: String
    var subtitle: String?
    var authors: [String]
    var description: String
    var industryIdentifiers: [ISBN]
    var imageLinks: ImageWrapper
}

struct PriceWrapper: Codable {
    var retailPrice: SalePriceWrapper
}

struct SalePriceWrapper: Codable {
    var amount: Double
    var currencyCode: String
}

struct ISBN: Codable {
    var identifier: String
    var type: String
    
}

struct ImageWrapper: Codable{
    var thumbnail: String 
}

