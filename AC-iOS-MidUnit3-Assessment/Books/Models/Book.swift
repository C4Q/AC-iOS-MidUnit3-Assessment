//
//  Book.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Book {
    let title: String
    let subtitle: String?
    let authors: [String]
    let summary: String
    let price: Double
    let image: String
    
    init(title: String, subtitle: String?, authors: [String], summary: String, price: Double, image: String) {
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.summary = summary
        self.price = price
        self.image = image
    }
    
    convenience init?(from bookDict: [String : Any]) {
        guard let title = bookDict["title"] as? String else {
            print("Error: Issue with getting title.")
            return nil
        }
        
        let subtitle = bookDict["subtitle"] as? String ?? ""
        
        guard let authors = bookDict["authors"] as? [String] else {
            print("Error: Issue with getting authors.")
            return nil
        }
        
        let summary = bookDict["description"] as? String ?? "No summary available."
        
        guard let imageDict = bookDict["imageLinks"] as? [String : Any] else {
            print("Error: Could not get images.")
            return nil
        }
        
        let image = imageDict["thumbnail"] as? String ?? "No image available."
        
        guard
            let salesInfoDict = bookDict["saleInfo"] as? [String : Any],
            let retailDict = salesInfoDict["retailPrice"] as? [String : Any], let price = retailDict["amount"] as? Double
            else {
            print("Error: Could not get sales info.")
            return nil
        }
        
        self.init(title: title, subtitle: subtitle, authors: authors, summary: summary, price: price, image: image)
    }
    
    static func getBooks(from data: Data) -> [Book] {
        var books: [Book] = []
        
        do {
            guard let jsonDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                print("Error: Could not get [String : Any] from data.")
                return []
            }
            
            guard let bookDictArray = jsonDict["items"] as? [[String : Any]] else {
                print("Error: Could not get [[String : Any]] from jsonDict.")
                return []
            }
            
            for bookDict in bookDictArray {
                if let book = Book(from: bookDict) {
                    books.append(book)
                }
            }
        } catch let error {
            print("*******************************")
            print(error.localizedDescription)
            print("*******************************")
            return []
        }
        
        return books
    }
    
}
