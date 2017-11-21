//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var jeopardyImage: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBAction func nextQuestionPressed(_ sender: UIButton) {
        let thisQuestion = nextQuestion()
        questionLabel.text = thisQuestion.question
        valueLabel.text = thisQuestion.value.description
        categoryLabel.text = thisQuestion.category
        correctAnswer = thisQuestion.answer
        messageLabel.text = "enter your answer"
        answerTextField.isEnabled = true
        answerTextField.text = ""
        
    }
    var correctAnswer: String = ""
      
    
    var questions = [JeopardyQuestion]()
    var randomIndex : Int {
        return Int(arc4random_uniform(UInt32(questions.count)))
        
    }
    //var currentQuestion: JeopardyQuestion?
    func nextQuestion() -> JeopardyQuestion {
        var currentIndex = randomIndex
        let currentQuestion = questions[currentIndex]
        currentIndex += 1
        if currentIndex == questions.count {
            currentIndex = 0
        }
        return currentQuestion
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                self.questions = JeopardyQuestion.getJeopardyQuestions(from: data)
            }
        }
    }
    
    func loadImageAndText() {
        
        jeopardyImage.image = #imageLiteral(resourceName: "jeopardyLogo")
        let initalQuestion = questions[randomIndex]
        correctAnswer = initalQuestion.answer
        questionLabel.text = initalQuestion.question
        valueLabel.text = initalQuestion.value.description
        categoryLabel.text = initalQuestion.category
        messageLabel.text = "enter your answer"
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text?.lowercased() == correctAnswer.lowercased() {
            messageLabel.text = "Correct!"
            textField.isEnabled = false
        } else {
            messageLabel.text = "Incorrect the answer was \(correctAnswer)"
            textField.isEnabled = false
        }
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.delegate = self
        loadData()
        loadImageAndText()
        // Do any additional setup after loading the view, typically from a nib.
    }

 

}

