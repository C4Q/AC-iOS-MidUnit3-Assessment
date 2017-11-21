//
//  Jeopardy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
//struct JeopardyQuestion: Codable {
//    let answer: String
//    let question: String
//    let value: Int
//    let category: CategoryWrapper
//}
//
//struct CategoryWrapper: Codable {
//    let title: String
//}


class JeopardyQuestion {
    var answer: String
    var question: String
    var value: Int
    var category: String
    init(answer: String, question: String, value: Int, category: String) {
        self.answer = answer
        self.question = question
        self.value = value
        self.category = category
    }
    convenience init?(from dict: [String: Any]) {
        guard let answer = dict["answer"] as? String else {return nil}
        guard let question = dict["question"] as? String else {return nil}
        guard let value = dict["value"] as? Int else {return nil}
        var category: String = ""
        if let categoryDict = dict["category"] as? [String: Any] {
            if let unwrappedCatagory = categoryDict["title"] as? String {
                category = unwrappedCatagory
            }
        }
        self.init(answer: answer, question: question, value: value, category: category)
    }
    static func getJeopardyQuestions(from data: Data) -> [JeopardyQuestion] {
        var questions = [JeopardyQuestion]()
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {return []}
        guard let jsonDictArr = json as? [[String: Any]] else {return []}
        for dict in jsonDictArr {
            if let question = JeopardyQuestion(from: dict) {
                questions.append(question)
            }
        }
        return questions
    }

    
}
