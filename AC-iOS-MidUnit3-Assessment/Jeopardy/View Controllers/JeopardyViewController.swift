//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {
    
    //Game Screen
    @IBOutlet var categoryLabels: [UILabel]!
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var noSuchQuestionLabel: UILabel!
    
    //Question Screen
    @IBOutlet weak var dailyDoubleLabel: UILabel!
    @IBOutlet weak var betPointsTextField: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var goBackButton: UIButton!
    
    let jeopardy = Jeopardy()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        betPointsTextField.delegate = self
        answerTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func pointsButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        sender.setTitleColor(.lightGray, for: .normal)
        
        guard
            let buttonTitle = sender.titleLabel?.text,
            let buttonPoints = Int(buttonTitle)
            else {
                print("Error: Could not convert button title to Int.")
                return
        }
        
        jeopardy.currentQuestionPoints = buttonPoints
        jeopardy.currentCategory = jeopardy.currentCategories[sender.tag]
        goBackButton.isHidden = true
        
        if let question = jeopardy.currentQuestion {
            if jeopardy.score <= 0 {
                dailyDoubleLabel.text = "Wow... you don't even have any points to bet 😂 Just put 0 LOL"
            }
            
            dailyDoubleLabel.isHidden = (question.value == nil) ? false : true
            betPointsTextField.isHidden = (question.value == nil) ? false : true
            questionLabel.isHidden = (question.value == nil) ? true : false
            answerTextField.isHidden = (question.value == nil) ? true : false
            
            noSuchQuestionLabel.isHidden = true
            betPointsTextField.isEnabled = true
            betPointsTextField.text = ""
            questionLabel.text = question.question.uppercased()
            answerTextField.isEnabled = true
            answerTextField.text = ""
        } else {
            noSuchQuestionLabel.isHidden = false
            return
        }
        
        switchViews()
    }
    
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        noSuchQuestionLabel.isHidden = true
        questionLabel.isHidden = true
        resultsLabel.isHidden = true
        resultsLabel.text = ""
        answerTextField.isHidden = true
        dailyDoubleLabel.isHidden = true
        betPointsTextField.isHidden = true
        switchViews()
    }
    
    
    func setupUI() {
        for index in 0..<jeopardy.currentCategories.count {
            categoryLabels[index].text = jeopardy.currentCategories[index].uppercased()
        }
    }
    
    func switchViews() {
        self.view.subviews[0].isHidden = !self.view.subviews[0].isHidden
        self.view.subviews[1].isHidden = !self.view.subviews[1].isHidden
    }
    
}

//MARK: - Text Field Delegate Methods
extension JeopardyViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == betPointsTextField {
            if string == "" {
                return true
            }
            
            if jeopardy.score <= 0 && string == "0" {
                return true
            } else if jeopardy.score > 0 && "0123456789".contains(string) {
                return true
            }
            return false
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == betPointsTextField {
            //setting up daily double
            guard let bet = Int(textField.text!) else {
                print("Error: Bet was not a number.")
                return false
            }
            
            if jeopardy.score <= 0 && bet != 0 {
                return false
            }
            
            if bet > jeopardy.score && bet != 0 {
                dailyDoubleLabel.text = "Wow... you can't place more than your score 😒"
                return false
            }
            
            dailyDoubleLabel.text = "It's the Daily Double!!!! Place your bet!"
            jeopardy.betPoints = bet
            dailyDoubleLabel.isHidden = true
            textField.isHidden = true
            questionLabel.isHidden = false
            answerTextField.isHidden = false
            
        } else if textField == answerTextField {
            //checking answers
            guard let userAnswer = textField.text else {
                print("Error: textfield was nil")
                return false
            }
            
            switch jeopardy.checkAnswer(userAnswer) {
            case true:
                resultsLabel.text = "Congrats, you got that right 😒"
            case false:
                resultsLabel.text = "LOL YOU GOT THAT WRONG!!!! 😂 The correct answer was \"\(jeopardy.answer)\"."
            }
            
            resultsLabel.isHidden = false
            goBackButton.isHidden = false
            jeopardy.betPoints = 0
        }
        
        currentScoreLabel.text = "CURRENT SCORE: \(jeopardy.score)"
        
        
        textField.isEnabled = false
        textField.resignFirstResponder()
        return true
    }
}
