//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeapordyViewController: UIViewController, UITextFieldDelegate {
    
    //Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var correctLabel: UILabel!
    
    
    var questions = [Questions]()
    var currentQuestion: Questions!
    var score: Double = 0.0
    var randomIndex: Int = 0
    var currentAnswer: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        loadData()
        randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
       
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     
        
        if (textField.text?.lowercased().contains(currentAnswer.lowercased()))! {
            print("TEST ANSWER: \(currentAnswer)")
        
            score = score + currentQuestion.value!
            scoreLabel.text = " Score: " + score.description
            correctLabel.backgroundColor = .green
            correctLabel.text = "Correct"
            correctLabel.isHidden = false
            textField.isEnabled = false
            nextButton.isEnabled = true
            
            textField.text = "Answer: What is " + currentAnswer
            return true
            
        } else {
            print("TEST ANSWER: \(currentAnswer)")
           
            score = score - currentQuestion.value!
            scoreLabel.text = " Score: " + score.description
            correctLabel.text = "Wrong"
            correctLabel.backgroundColor = .red
            correctLabel.isHidden = false
            textField.isEnabled = false
            nextButton.isEnabled = true
            
            textField.text = "Answer: What is " +  currentAnswer
            return false
        }
    }
    
    
    
    
    @IBAction func nextQuestionButton(_ sender: UIButton) {
        randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
        currentQuestion = questions[randomIndex]
        currentAnswer = currentQuestion.answer
        questionLabel.text = "Question: " + currentQuestion.question
        pointsLabel.text = "Points: " + "\(currentQuestion.value ?? 0)"
        categoryLabel.text = "Category: " + currentQuestion.title
        correctLabel.isHidden = true
        textField.isEnabled = true
        textField.text = ""
        nextButton.isEnabled = false
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            
            let myURL = URL(fileURLWithPath: path)
            
            if let data = try? Data(contentsOf: myURL){
                
                questions = Questions.getQuestions(from: data)
                
                for _ in questions {
                    randomIndex = Int(arc4random_uniform(UInt32(questions.count)))
                    
                    
                    
                    nextButton.isEnabled = false
                    currentQuestion = questions[randomIndex]
                    currentAnswer = currentQuestion.answer
                    // dump(currentQuestion)
                    categoryLabel.text = "Category: " + currentQuestion.title
                    pointsLabel.text = "Points: " + (currentQuestion.value?.description)!
                    questionLabel.text = "Question: " + currentQuestion.question
                    print("""
                        
                        
                        Question: \(currentQuestion.question),
                        Answer: \(currentQuestion.answer)
                        Value: \(currentQuestion.value ?? 0)
                        
                        
                        """)
                    
                    
                }
                
                
                
                
            }
            
        }
    }
    
}
