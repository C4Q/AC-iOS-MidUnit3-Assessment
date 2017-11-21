//
//  NetworkHelper.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Reiaz Gafar on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

class NetworkHelper {
    
    func getImage(url: String) -> UIImage {
        var image = UIImage()

        
        let imageURL = URL(string: url)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            image = UIImage(data: imageData)!
        }
        
        return image
    }
    
    
}
