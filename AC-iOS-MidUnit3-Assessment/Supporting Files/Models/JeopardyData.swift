//
//  JeopardyData.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Reiaz Gafar on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct JeopardyQuestion {
    var answer: String
    var question: String
    var value: Int?
    var category: String
    
    init(answer: String, question: String, value: Int?, category: String) {
        self.answer = answer
        self.question = question
        self.value = value
        self.category = category
    }
    
    init?(from dict: [String : Any]) {
        guard let answer = dict["answer"] as? String else { return nil }
        guard let question = dict["question"] as? String else { return nil  }
        guard let value = dict["value"] as? Int? else { return nil }
        guard let categoryDict = dict["category"] as? [String : Any] else { return nil }
        guard let category = categoryDict["title"] as? String else { return nil }
        self.answer = answer
        self.question = question
        self.value = value
        self.category = category
    }
    
    static func getJeopardyQuestions() -> [JeopardyQuestion] {
        var questions = [JeopardyQuestion]()
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let questionArray = json as? [[String : Any]] {
                        for question in questionArray {
                            if let question = JeopardyQuestion(from: question) {
                                questions.append(question)
                            }
                        }
                    }
                } catch let error {
                    print(error)
                }
            }
        }
        return questions
    }
 
}
