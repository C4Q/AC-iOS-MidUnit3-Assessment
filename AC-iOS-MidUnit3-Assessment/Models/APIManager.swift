//
//  APIManager.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
class APIManager {
    func getData(endpoint: String, completionHandler: @escaping (Data?) ->())  {
        guard let url = URL(string: endpoint) else {return }
        let request = URLRequest(url: url)
        
        let task  = URLSession.shared.dataTask(with: request) {(data: Data?, response: URLResponse?, error: Error?) in
            if let myError = error {
                print(myError)
                completionHandler(nil)
            }
            if let myData = data {
                completionHandler(myData)
            }
        }
        task.resume()
    }
}
