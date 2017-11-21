//
//  BookData.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class BookData: Codable {
    let items: [Book]
}
class Book: Codable {
    let volumeInfo: VolumeInfoList
    let saleInfo: SaleInfoList
}
class VolumeInfoList: Codable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let imageLinks: ImageWraper
    let description: String
     let industryIdentifiers: [ISBNWraper]
}
class SaleInfoList: Codable {
    let retailPrice: PriceDict
}
class PriceDict: Codable {
    let amount: Double?
    let currencyCode: String?
}
class ImageWraper: Codable {
    let thumbnail: String
}

class ISBNWraper: Codable {
    let type: String
    let identifier: String
}

class BookAPIManager {
    var books = [Book]()
    
    func getBooks() -> [Book] {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myUrl = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: myUrl)
                let decoder = JSONDecoder()
                
                do {
                    let bookData = try decoder.decode(BookData.self, from: data)
                        self.books = bookData.items
                    
                } catch {
                    print("DECODE ERROR")
                    print(error)
                }
                
            } catch {
                print(error)
            }
        }
        return self.books
    }
    
    
}
