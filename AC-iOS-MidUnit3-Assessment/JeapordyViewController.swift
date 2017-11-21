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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        loadData()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text?.lowercased() == currentQuestion.answer.lowercased() {
            score = score + currentQuestion.value!
            scoreLabel.text = " Score: " + score.description
            correctLabel.backgroundColor = .green
            correctLabel.text = "Correct"
            correctLabel.isHidden = false
            textField.isEnabled = false
            nextButton.isEnabled = true
            
            return true
            
        } else {
            score = score - currentQuestion.value!
            scoreLabel.text = " Score: " + score.description
            correctLabel.text = "Wrong"
                        correctLabel.backgroundColor = .red
            correctLabel.isHidden = false
            textField.isEnabled = false
            nextButton.isEnabled = true
            
            return false
        }
    }
    
    
  
    
    @IBAction func nextQuestionButton(_ sender: UIButton) {
        questionLabel.text = "Question: " + currentQuestion.question
        pointsLabel.text = "Points: " + (currentQuestion.value?.description)!
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
                
                
                
                for question in questions {
 
                    nextButton.isEnabled = false
                    currentQuestion = question
                    dump(currentQuestion)
                    categoryLabel.text = "Category: " + currentQuestion.title
                    pointsLabel.text = "Points: " + (currentQuestion.value?.description)!
                    questionLabel.text = "Question: " + currentQuestion.question
                        break
                    }
    
        
    
            }
            
        }
    }
    
}
