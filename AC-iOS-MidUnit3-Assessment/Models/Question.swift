//
//  JeopardyModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Question {
    let question: String
    let answer: String
    let value: Int?
    let title: String?
    init(question: String, answer: String, value: Int?,  title: String?) {
        self.question = question
        self.answer = answer
        self.value = value
        self.title = title
    }
    convenience init?(from jsonDict: [String:Any]) {
        guard let question = jsonDict["question"] as? String else {return nil}
        guard let answer = jsonDict["answer"] as? String else {return nil}
        guard let value = jsonDict["value"] as? Int? else {return nil}
        var title: String?
        if let categoryDict = jsonDict["category"] as? [String: String] {
            title = categoryDict["title"]
        }
        self.init(question: question, answer: answer, value: value, title: title)
    }
    static func getQuestions(from data: Data) -> [Question] {
        var questions = [Question]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options:[])
            if let questionsArray = json as? [[String: Any]] {
                for questionDict in questionsArray {
                    if let question = Question(from: questionDict) {
                        questions.append(question)
                    }
                }
            }
        }
        catch {
            print("Error converting data to JSON")
        }
        return questions
    }
}

