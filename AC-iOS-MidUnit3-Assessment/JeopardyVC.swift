//  jeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class JeopardyVC: UIViewController{
	
	//Outlets
	@IBOutlet weak var categoryLabel: UILabel!
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var valueLabel: UILabel!
	@IBOutlet weak var messageLabel: UILabel!
	@IBOutlet weak var scoreLabel: UILabel!
	
	//Actions
	@IBAction func nextQuestionPressed(_ sender: UIButton) {
		loadQuestion()

	}
	//MARK: - Variables/constants
	var questions = [Jeopardy]()
	var numOfTotalQuestions: Int = 0
	var randInt: Int = 0
	var currentQuestion: Jeopardy!
	var playerScore: Int = 0
	var answer: String = ""
	
	//MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		loadQuestion()
		playerScore = 0
		numOfTotalQuestions = questions.count
		randInt = Int(arc4random_uniform(UInt32(numOfTotalQuestions)))
		
	}
	
	func loadQuestion(){
		numOfTotalQuestions = questions.count
		currentQuestion = questions[randInt]
		categoryLabel.text =  "Category: \(currentQuestion.category.title)"
		questionLabel.text = "Question: \(currentQuestion.question)"
		valueLabel.text = "Value: \(currentQuestion.value ?? 0)"
		scoreLabel.text = "Score: \(playerScore)"
		messageLabel.text = ""
		messageLabel.isHidden = true
		answer = currentQuestion.answer
	}
	
	//MARK: - Functions
	func loadJeopardyData() {
		if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
			let url = URL(fileURLWithPath: path)
			if let data = try? Data(contentsOf: url) {
				do {
					let jeopardy = try JSONDecoder().decode(Jeopardy.self, from: data)
					self.currentQuestion = jeopardy
				}
				catch {
					print(error)
				}
			}
		}
	}
	
}

extension JeopardyVC: UITextFieldDelegate {
	//MARK: TextField
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		guard let text = textField.text else {
			return false
		}
		
		if currentQuestion.answer.lowercased().contains(text.lowercased()){
			messageLabel.text = "Correct. Answer is: \(answer)"
		} else {
			messageLabel.text = "Incorrect. Answer was: \(text)"
		}
		messageLabel.isHidden = false
		textField.text = ""
		textField.resignFirstResponder()
		return true
	}
}




