//  jeopardy.swift
//  AC-iOS-MidUnit3-Assessment
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

class Question {
	let answer: String
	let question: String
	let value: Int?
	var title: String?
	
	init(answer: String, question: String, value: Int?, title: String?) {
		self.answer = answer
		self.question = question
		self.value = value
		self.title = title
		return
	}
	
	convenience init?(from jsonDict: [String: Any]) {
		guard let question = jsonDict["question"] as? String else { return nil }
		guard let categoryDict = jsonDict["category"] as? [String: Any] else {
			return nil
		}
		guard let title = categoryDict["title"] as? String else { return nil }
		let answer = (jsonDict["answer"] as? String) ?? " "
		let value = (jsonDict["value"] as? Int) ?? 0
		self.init(answer: answer, question: question, value: value, title: title)
	}
	
	static func getQuestions(from data: Data) -> [Question] {
		var questions = [Question]()
		do {
			let json = try JSONSerialization.jsonObject(with: data, options: [])
			if let questionDictArray = json as? [[String:Any]] {
				for questionDict in questionDictArray {
					if let question = Question(from: questionDict) {
						questions.append(question)
						print(String(describing: question.title))
					}
				}
			}
		}
		catch {
			print("Error converting data to JSON. \(error)")
		}
		return questions
	}
}


