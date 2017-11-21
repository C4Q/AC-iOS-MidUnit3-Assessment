//  jeopardy.swift
//  AC-iOS-MidUnit3-Assessment
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

class Questions {
	let answer: String
	let question: String
	let value: Int?
	let title: String
	
	init(answer: String, question: String, value: Int?, title: String?) {
		self.answer = answer
		self.question = question
		self.value = value
		self.title = title!
		return
	}
	
	convenience init?(from jsonDict: [String: Any]) {
		guard
			let question = jsonDict["question"] as? String,
			let answer = jsonDict["answer"] as? String
		else {
			return nil
		}
			let value = jsonDict["value"] as? Int ?? 0
			var title: String?

			if let categoryDict = jsonDict["category"] as? [String: String] {
				title = categoryDict["title"]!
			}
		self.init(answer: answer, question: question, value: value, title: title)

	}
	
	static func getQuestions(from data: Data) -> [Questions] {
		var questions = [Questions]()
		do {
			let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
			guard let questionsDictArr = jsonDict as? [[String:Any]] else { return []}
			for questionsDict in questionsDictArr {
				if let question = Questions(from: questionsDict) {
					questions.append(question)
				}
			}
		}
		catch {
			print("Error converting data to JSON")
		}
		return questions
	}
}


