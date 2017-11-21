//
//  JeopardyModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Richard Crichlow on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class GameBrain {
    var currentQuestion: String = ""
    var currentAnswer: String = ""
    var currentValue: Int? = 0
    var currentCategory: String = ""
    var currentScore: Int = 0
    var playerString = String()
    var counter = 0
}

class Questions {
    var question: String
    var value: Int?
    var answer: String
    var category: String
    init(question: String, value: Int?, answer: String, category: String) {
        self.answer = answer
        self.value = value
        self.question = question
        self.category = category
    }
    convenience init?(from dict: [String: Any]) {
        let question = dict["question"] as? String ?? "Mystery Question"
        let value = dict["value"] as? Int ?? 0
        guard let answer = dict["answer"] as? String else {return nil}
        guard let category = dict["category"] as? [String: Any] else {return nil}
        let title = category["title"] as? String ?? "Mystery Category"
        self.init(question: question, value: value, answer: answer, category: title)
    }
    static func getQuestions(from data: Data) -> [Questions] {
        var questions = [Questions]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = json as? [[String: Any]] else {return [] }
            for questionDict in jsonDict {
                if let newQuestion = Questions(from: questionDict) {
                    questions.append(newQuestion)
                }
            }
        } catch {
            print("JSON Serialization did not work buddy")
        }
        return questions
    }
}



