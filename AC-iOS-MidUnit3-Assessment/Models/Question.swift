//
//  Question.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Luis Calle on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Question {
    let category: String
    let question: String
    let answer: String
    let value: Int
    init(category: String, question: String, answer: String, value: Int) {
        self.category = category
        self.question = question
        self.answer = answer
        self.value = value
    }
    convenience init?(from dict: [String:Any]) {
        let theQuestion = dict["question"] as? String ?? "Question not found"
        let theAnswer = dict["answer"] as? String ?? "Answer not found"
        let theValue = dict["value"] as? Int ?? 0
        guard let categoryDict = dict["category"] as? [String:Any] else { return nil }
        let theCategory = categoryDict["title"] as? String ?? "Category Not Found"
        self.init(category: theCategory, question: theQuestion, answer: theAnswer, value: theValue)
    }
    
    static func getallQuestions(from data: Data) -> [Question] {
        var questions = [Question]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let questionsDictArray = json as? [[String: Any]] else { return [] }
            for questionDict in questionsDictArray {
                if let newQuestion = Question(from: questionDict) {
                    questions.append(newQuestion)
                }
            }
        }
        catch {
            print("Error")
        }
        return questions
    }
    
}
