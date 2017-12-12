//
//  Books.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

struct Books: Codable {
    let items: [Book]
}

struct Book: Codable{
    let volumeInfo: BookInfoWrapper
    let saleInfo: PriceWrapper
}

struct BookInfoWrapper: Codable{
    let title: String
    let subtitle: String?
    let authors:[String]
    
    var allAuthors: String {
        var authorsAsString = ""
        for authors in authors{
            authorsAsString.append(authors)
        }
        return authorsAsString
    }
    
    let description: String
    let imageLinks: ImageWrapper
    let industryIdentifiers: [ISBN13Info]
}

struct ImageWrapper: Codable {
    let smallThumbnail: String
    let thumbnail: String
}

struct ISBN13Info: Codable {
    let type: String
    let identifier: String
//    var bookID: String {
//        var iSBN = ""
//        for bookID in books{
//            //if the key == "ISBN_13
//            //if idtentifier == 97800...
//            //return that index
//        }
//
//    }
}


struct PriceWrapper: Codable {
    let retailPrice: CostWrapper
}

struct CostWrapper: Codable {
    let amount: Double
}

class BookInformation{
    
    //https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values
    //using hex values
    
    func hexStringToUIColor (hex:String) -> UIColor? {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}



