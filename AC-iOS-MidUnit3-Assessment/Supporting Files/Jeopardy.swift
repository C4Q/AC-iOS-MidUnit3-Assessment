//
//  Jeopardy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Jeopardy {
    
    static var counter: Int = 0
    static var points: Int = 0

    let answer: String
    let question: String
    let value: Int?
    let categoryTitle: String

    init(answer: String, question: String, value: Int?, categoryTitle: String) {
        self.answer = answer
        self.question = question
        self.value = value
        self.categoryTitle = categoryTitle
    }
    
    convenience init?(from dict: [String: Any]) {
        var cateTitle: String = ""
        if let categoryDict = dict["category"] as? [String: Any] {
            if let unwrappedCategory = categoryDict["title"] as? String {
                cateTitle = unwrappedCategory
            }
        }

        guard
            let answer = dict["answer"] as? String,
            let question = dict["question"] as? String,
            let value = dict["value"] as? Int
            else {
                return nil
        }
        
        self.init(answer: answer, question: question, value: value, categoryTitle: cateTitle)
    }
    
    static func createArrayOfQuestions(from data: Data) -> [Jeopardy]? {
        var questionsList: [Jeopardy] = []
        
        do {
            guard let jeopardyJSONArr = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                else { return nil }
            
            for jeopardyDict in jeopardyJSONArr {
                if let thisQuestion = Jeopardy(from: jeopardyDict) {
                    questionsList.append(thisQuestion)
                }
            }
            
        } catch let error {
            print(error)
        }
        
        return questionsList
    }
    
}
