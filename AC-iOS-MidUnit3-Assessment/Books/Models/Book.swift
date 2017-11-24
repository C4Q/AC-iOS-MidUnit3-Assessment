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
    let subtitle: String
    let authors: [String]
    let summary: String
    let isbn13: String
    let price: Double
    let imageURL: String
    
    init(title: String, subtitle: String, authors: [String], summary: String, isbn13: String, price: Double, imageURL: String) {
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.summary = summary
        self.isbn13 = isbn13
        self.price = price
        self.imageURL = imageURL
    }
    
    convenience init?(from bookDict: [String : Any]) {
        
        guard
            let volumeInfoDict = bookDict["volumeInfo"] as? [String : Any],
            let title = volumeInfoDict["title"] as? String else {
                print("Error: Issue with getting title.")
                return nil
        }
        
        let subtitle = volumeInfoDict["subtitle"] as? String ?? ""
        
        guard let authors = volumeInfoDict["authors"] as? [String] else {
            print("Error: Issue with getting authors.")
            return nil
        }
        
        let summary = volumeInfoDict["description"] as? String ?? "No summary available."
        
        //Book Extra Credit #1
        guard
            let identifierDict = volumeInfoDict["industryIdentifiers"] as? [[String : Any]],
            let isbn13 = identifierDict[0]["identifier"] as? String
            else {
                print("Error: Could not get ISBN 13.")
                return nil
        }
        
        guard let imageDict = volumeInfoDict["imageLinks"] as? [String : Any] else {
            print("Error: Could not get images.")
            return nil
        }
        
        let imageURL = imageDict["thumbnail"] as? String ?? "No image available."
        
        guard
            let salesInfoDict = bookDict["saleInfo"] as? [String : Any],
            let retailDict = salesInfoDict["retailPrice"] as? [String : Any], let price = retailDict["amount"] as? Double
            else {
                print("Error: Could not get sales info.")
                return nil
        }
        
        self.init(title: title, subtitle: subtitle, authors: authors, summary: summary, isbn13: isbn13, price: price, imageURL: imageURL)
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
