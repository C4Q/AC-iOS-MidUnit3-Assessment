//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Richard Crichlow on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var messageToUser: UILabel!
    
    @IBOutlet weak var texfield: UITextField!
    
    @IBAction func nextQuestionButton(_ sender: UIButton) {
        nextQuestion()
    }
    
    var jeopardyQuestions = [Questions]()
    var gameBrain = GameBrain()
    
    //Mark - Textfield Delegates
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            messageToUser.text = "Invalid Input"
            messageToUser.isHidden = false
            return true
        }
        gameBrain.playerString = text.lowercased()
        if gameBrain.currentAnswer == gameBrain.playerString || "the \(gameBrain.currentAnswer)" == gameBrain.playerString || "a \(gameBrain.currentAnswer)" == gameBrain.playerString {
            messageToUser.text = "Corrent Answer!"
            gameBrain.currentScore += gameBrain.currentValue!
            self.view.backgroundColor = .green
        } else {
            messageToUser.text = "Incorrect Answer! The correct answer was \(gameBrain.currentAnswer)"
            gameBrain.currentScore -= gameBrain.currentValue!
            self.view.backgroundColor = .red
            
        }
        scoreLabel.text = "Score: \(gameBrain.currentScore)"
        textField.text = ""
        return true
    }
    
    func nextQuestion() {
        gameBrain.currentQuestion = jeopardyQuestions[gameBrain.counter].question
        gameBrain.currentAnswer = jeopardyQuestions[gameBrain.counter].answer.lowercased()
        print(gameBrain.currentAnswer)
        gameBrain.currentValue = jeopardyQuestions[gameBrain.counter].value
        gameBrain.currentCategory = jeopardyQuestions[gameBrain.counter].category.capitalized
        gameBrain.counter += 1
        if gameBrain.counter >= jeopardyQuestions.count {
            gameBrain.counter = 0
        }//To prevent index out of bounds crash
        categoryLabel.text = gameBrain.currentCategory
        messageToUser.text = "Guess The Answer!"
        valueLabel.text = "Value: \(gameBrain.currentValue ?? 0)"
        questionLabel.text = gameBrain.currentQuestion
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        texfield.delegate = self
        loadData()
        nextQuestion()
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                self.jeopardyQuestions = Questions.getQuestions(from: data)
            } else {
                print("JSON Serialization didn't work. Git Gud")
            }
        }
    }
}
