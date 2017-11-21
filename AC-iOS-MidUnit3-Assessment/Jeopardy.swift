//  jeopardy.swift
//  AC-iOS-MidUnit3-Assessment
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.

import Foundation

enum GuessResult {
	case correct, incorrect, almostCorrect
}

struct Jeopardy: Codable {
	let id: Int
	let answer: String
	let question: String
	let value: Int?
	let category: CategoryWrapper
	
}

struct CategoryWrapper: Codable {
	let title: String
}


//struct Question {
//	private let question = []() //array of questions
//	private let answer: String
//	private var userGuess: String
//
//	mutating func guess(_ userAnswer: String) -> GuessResult {
//		if answer == userGuess {
//			return .correct
//		} else if answer.contains(userGuess) {
//			return .almostCorrect
//		} else {
//			return .incorrect
//		}
//	}

//	init() {
////		let randInt = Int(arc4random_uniform(50)) //if 50 questions - count objects in model
////		self.answer = Questions(randInt).answer  //Questions is the array of all questions, randInt to select random question, then get the random answer
//	}
//}


