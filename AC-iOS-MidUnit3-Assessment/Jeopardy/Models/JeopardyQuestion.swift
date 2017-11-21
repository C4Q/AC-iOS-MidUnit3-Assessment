//
//  JeopardyInfo.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class JeopardyQuestion {
    let question: String
    let answer: String
    let value: Int?
    let category: String
    var dailyDouble: Bool {
        if value != nil {
            return false
        }
        return true
    }
    
    init(question: String, answer: String, value: Int?, category: String) {
        self.question = question
        self.answer = answer
        self.value = value
        self.category = category
    }
    
    convenience init?(from jeopardyDict: [String : Any]) {
        guard let answer = jeopardyDict["answer"] as? String else {
            print("Error: Issue with getting answer.")
            return nil
        }
        
        guard let question = jeopardyDict["question"] as? String else {
            print("Error: Issue with getting question.")
            return nil
        }
        
        let value = jeopardyDict["value"] as? Int ?? nil
        
        guard
            let categoryDict = jeopardyDict["category"] as? [String : Any],
            let category = categoryDict["title"] as? String
            else {
                print("Error: Issue with getting category.")
                return nil
        }
        
        self.init(question: question, answer: answer, value: value, category: category)
    }
    
    static func getJeopardyData(from data: Data) -> [JeopardyQuestion] {
        var jeopardyQuestions: [JeopardyQuestion] = []
        
        do {
            guard let jeopardyDictArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] else {
                print("")
                return []
            }
            
            for jeopardyDict in jeopardyDictArray {
                if let jeopardyQuestion = JeopardyQuestion(from: jeopardyDict) {
                    jeopardyQuestions.append(jeopardyQuestion)
                }
            }
            
        } catch let error {
            print("*******************************")
            print(error.localizedDescription)
            print("*******************************")
        }
        
        return jeopardyQuestions
    }
    
}
