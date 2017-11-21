//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Richard Crichlow on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var messageToUser: UILabel!
    
    @IBAction func nextQuestionButton(_ sender: UIButton) {
        nextQuestion()
        categoryLabel.text = gameBrain.currentCategory
        messageToUser.text = "Guess The Answer!"
        valueLabel.text = "Value: \(gameBrain.currentValue ?? 0)"
        questionLabel.text = gameBrain.currentQuestion
    }
    
    @IBOutlet weak var texfield: UITextField!
    
    var jeopardyQuestions = [Questions]()
    var gameBrain = GameBrain()
    var counter = 0
    func nextQuestion() {
        gameBrain.currentQuestion = jeopardyQuestions[counter].question
        gameBrain.currentAnswer = jeopardyQuestions[counter].answer
        gameBrain.currentValue = jeopardyQuestions[counter].value
        gameBrain.currentCategory = jeopardyQuestions[counter].category
        counter += 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
