//
//  APIManager.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class APIManager {
    //API requests
    func getData(endpoint: String, completionHandler: @escaping (Data?) -> ()) {
        guard let url = URL(string: endpoint) else {
            print("Error: Incorrect format for a URL. Please check the endpoint.")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print("*******************************")
                print(error.localizedDescription)
                print("*******************************")
                completionHandler(nil)
                return
            }
            
            if let data = data {
                completionHandler(data)
            }
        }
      task.resume()
    }
    
    //JSON files - downcasting
    func getData(forResource fileName: String, ofType fileType: String, completionHandler: @escaping (Data?) -> ()) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: fileType) else {
            print("Error: Could not get path.")
            return
        }
        
        let url = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: url)
            completionHandler(data)
        } catch let error {
            print("*******************************")
            print(error.localizedDescription)
            print("*******************************")
            completionHandler(nil)
        }
    }
    
}
