//
//  Jepoardy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

struct JeopardyInfo: Codable{
    let answer: String
    let question: String
    let value: Int?
    let category: CategoryWrapper
    
}

struct CategoryWrapper: Codable{
    let title: String
}

class JeopardyInformation{
    
    //https://stackoverflow.com/questions/24263007/how-to-use-hex-colour-values
    //using hex values
    
    func hexStringToUIColor (hex:String) -> UIColor {
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


class Brain {
    
    var questionValue: Int = 0
    var questionCategory: String = ""
    var =
    var =
    
    
}

