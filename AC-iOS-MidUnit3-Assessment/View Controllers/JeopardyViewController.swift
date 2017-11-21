//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    var questions = [Question]()
    var currentQuestion: Question? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        loadQuestions()
        loadCurrentQuestion()

    }
/// When the view loads, a question should already by loaded for the user to view.
    func loadQuestions() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let questions = Question.getQuestions(from: data)
                self.questions = questions
            }
        }
    }
    
    func loadCurrentQuestion() {
        let randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
        currentQuestion = questions[randomIndex]
        if let question = currentQuestion {
            self.questionTextView.text = question.question
            self.valueLabel.text = "\(String(describing: question.value!)) Points"
//            self.categoryLabel.text = "Category: " + question.title! /// find a way to unwrap this safely
        }
    }
    

    /// When the user presses return after inputing a guess to the text field, a message should display.
/// The message should tell the user whether or not they guessed correctly and display the correct answer if they guessed wrong.
    /// You should be comparing the user's guess against the correct answer case insensitively. Don't worry about the user getting it wrong because of a slight difference between their answer and the correct answer. For example, it's fine if the user gets it wrong when entering "foray" when the correct answer is "a foray".
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        guard let userInput = textField.text else {
            return false
        }
        if let question = currentQuestion {
            if (question.answer.contains(userInput)) {
                responseLabel.text = "Correct!"
                responseLabel.isHidden = false
            } else {
                responseLabel.text = "Sorry, the correct answer was \(question.answer)"
            }
        }
            return true
        }

    @IBAction func nextQuestionButtonPressed(_ sender: UIButton) {
        loadCurrentQuestion()
        
        
    }
    
    
    
}
