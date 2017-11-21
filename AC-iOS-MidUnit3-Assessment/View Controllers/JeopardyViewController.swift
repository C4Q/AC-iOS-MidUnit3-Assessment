//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Luis Calle on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {

    @IBOutlet weak var jeopardyLogoImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var inputAnswerTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var allQuestions = [Question]()
    var jeopardyBrain = JeopardyGameModel()
    var currentQuestion: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inputAnswerTextField.delegate = self
        loadQuestionsData()
        jeopardyBrain.addQuestions(questions: allQuestions)
        currentQuestion = jeopardyBrain.getRandomQuestion()
        guard let currentQuestion = currentQuestion else { return }
        setUIForQuestion(question: currentQuestion)
        scoreLabel.text = "Score: \(jeopardyBrain.getScore())"
    }
    
    func loadQuestionsData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let theURL = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: theURL)
                self.allQuestions = Question.getallQuestions(from: data)
            }
            catch let error {
                print(error)
            }
        }
    }
    
    func setUIForQuestion(question: Question) {
        categoryLabel.text = question.category
        questionLabel.text = question.question
        valueLabel.text = "$\(question.value.description)"
    }

    @IBAction func nextQuestionButtonPressed(_ sender: UIButton) {
        inputAnswerTextField.isEnabled = true
        inputAnswerTextField.text = ""
        currentQuestion = jeopardyBrain.getRandomQuestion()
        messageLabel.text = "Enter your answer above"
        guard let currentQuestion = currentQuestion else { return }
        setUIForQuestion(question: currentQuestion)
    }
    
}

extension JeopardyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentQuestion = currentQuestion else { return false }
        guard let textFieldText = textField.text else { return false }
        if currentQuestion.answer.lowercased().contains(textFieldText.lowercased()) {
            messageLabel.text = "Correct"
            jeopardyBrain.addScore(value: currentQuestion.value)
        } else {
            messageLabel.text = "Wrong! Correct aswer was: \(currentQuestion.answer)"
            jeopardyBrain.subtractScore(value: currentQuestion.value)
        }
        scoreLabel.text = "Score: \(jeopardyBrain.getScore())"
        inputAnswerTextField.isEnabled = false
        textField.resignFirstResponder()
        return true
    }
    
}
