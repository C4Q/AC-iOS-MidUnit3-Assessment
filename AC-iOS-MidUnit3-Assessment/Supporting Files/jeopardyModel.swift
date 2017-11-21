//
//  jeopardyModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Jeopardy: Codable {
    let answer: String
    let question: String
    let value: Int?
    let category: Category
    
//    init(answer: String, question: String, value: Int, category: Category) {
//        self.answer = answer
//        self.question = question
//        self.value = value
//        self.category = category
//    }
//
//    convenience init?(from dict: [String: Any]) {
//     guard
//        let answer = dict["answer"] as? String,
//        let question = dict["question"] as? String,
//        let value = dict["value"] as? Int,
//        let categoryDict = dict["category"] as? String
//        else { return }
//    }
//    self.init(answer: answer, )
}


struct Category: Codable {
    let title: String
    
//    init(title: String) {
//        self.title = title
//    }
//
//    init(JSONCategoryDict: [String : Any]) {
//        guard let title = JSONCategoryDict["title"] as? String else { return }
//        self.title = title
//    }
}

class DecodedJSON {
    static func getData() -> [Jeopardy] {
        var parsedJeopardyInfo = [Jeopardy]()
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                do {
                    let jeopardy = try JSONDecoder().decode(Jeopardy.self, from: data)
                    parsedJeopardyInfo = [jeopardy]
                }
                catch {
                    print(error)
                }
            }
        }
        return parsedJeopardyInfo
    }
}



