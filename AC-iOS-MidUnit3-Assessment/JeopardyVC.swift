//  jeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class JeopardyVC: UIViewController, UITextFieldDelegate{
	
	//Outlets
	@IBOutlet weak var categoryLabel: UILabel!
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var valueLabel: UILabel!
	@IBOutlet weak var messageLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	@IBOutlet weak var guessTextField: UITextField!
	
	@IBAction func nextQuestionPress(_ sender: UIButton) {
		loadQuestion()
	}
	
	//MARK: - Variables/constants
	var questions = [Question]()
	var numOfTotalQuestions: Int = 0
	var randInt: Int = 0
	var playerScore: Int = 0
	var answer: String = ""
	var value: Int? = 0
	
	//MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		guessTextField.delegate = self
		loadData()
		loadQuestion()
		playerScore = 0
		numOfTotalQuestions = questions.count
	}
	
	func loadData() {
		if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
			let myURL = URL(fileURLWithPath: path)
			if let data = try? Data(contentsOf: myURL) {
				let questions = Question.getQuestions(from: data)
				self.questions = questions
			}
		}
		for question in questions {
			print(question.question)
		}
	}
	
	func loadQuestion(){
		randInt = Int(arc4random_uniform(UInt32(numOfTotalQuestions)))
		let currentQuestion = questions[randInt]
		categoryLabel.text = "Category: \(currentQuestion.title ?? "")"
		questionLabel.text = "Question: \(currentQuestion.question)"
		valueLabel.text = "Value: \(currentQuestion.value ?? 0)"
		scoreLabel.text = "Score: \(playerScore)"
		messageLabel.text = " "
		answer = currentQuestion.answer
		value = currentQuestion.value ?? 0
		guessTextField.isEnabled = true
		guessTextField.placeholder = "enter your answer"
	}
	
}

extension JeopardyVC {
	//MARK: TextField
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if answer.lowercased() == textField.text?.lowercased() {
			messageLabel.text = "Correct. Answer is: \(answer)"
			playerScore += ((value ?? 0) > 0) ? value! : 0
			scoreLabel.text = "Score: \(playerScore)"
		} else {
			messageLabel.text = "Incorrect. Answer was: \(answer)"
			playerScore -= ((value ?? 0) > 0) ? value! : 0
			scoreLabel.text = "Score: \(playerScore)"
		}
		textField.text = ""
		textField.resignFirstResponder()
		return true
	}
}





