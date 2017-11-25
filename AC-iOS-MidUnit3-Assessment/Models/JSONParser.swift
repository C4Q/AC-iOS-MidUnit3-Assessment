//
//  NetworkHelper.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Clint Mejia on 11/22/17.
//  Copyright © 2017 C4Q . All rights reserved.
//
import Foundation
import UIKit

class MyJSONParser {
    
    func getData<T>(from file: String) -> [T] {
        var indices = [T]()
        guard let path = Bundle.main.path(forResource: file, ofType: "json") else { return indices}
        let myURL = URL(fileURLWithPath: path)
        if let data = try? Data(contentsOf: myURL) {
            do {
                indices = try JSONDecoder().decode([T].self, from: data)
                return indices
            }
            catch {
                print("Error Decoding Data")
            }
        }
        return indices
    }
    
    func getImage(url: String) -> UIImage {
        var thumbnail = UIImage()
        let thumbmailURL = URL(string: url)
        let data = try? Data(contentsOf: thumbmailURL!)
        
        if let imageData = data {
            thumbnail = UIImage(data: imageData)!

        }
        return thumbnail
    }

}
