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
    @IBOutlet var buttons: [UIButton]!
    
    //Question Screen
    @IBOutlet weak var dailyDoubleLabel: UILabel!
    @IBOutlet weak var betPointsTextField: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var goBackButton: UIButton!
    
    //Game Over Screen
    @IBOutlet weak var gameOverMessageLabel: UILabel!
    
    var jeopardy = Jeopardy()
    
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
//        goBackButton.isHidden = true
        
        if let question = jeopardy.currentQuestion {
            dailyDoubleLabel.text = (jeopardy.score <= 0) ? "Wow... you don't even have any points to bet 😂 Just put 0 LOL" : "It's the Daily Double!!!! Place your bet!"
            
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
            checkForGameOver()
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
        
        checkForGameOver()
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        let newJeopardy = Jeopardy()
        jeopardy = newJeopardy
        jeopardy.score = 0
        setupUI()
    }
    
    func setupUI() {
        currentScoreLabel.text = "CURRENT SCORE: \(jeopardy.score)"
        
        for button in buttons {
            button.isEnabled = true
            button.setTitleColor(UIColor(red: 0.968, green: 0.853, blue: 0.216, alpha: 1), for: .normal)
        }
        
        for index in 0..<jeopardy.currentCategories.count {
            categoryLabels[index].text = jeopardy.currentCategories[index].uppercased()
        }
        
        for subview in self.view.subviews {
            if subview.tag == 0 {
                subview.isHidden = false
            }
        }
        
    }
    
    func switchViews() {
        for subview in self.view.subviews where (subview.tag == 0) || (subview.tag == 1) {
                subview.isHidden = !subview.isHidden
        }
    }
    
    func checkForGameOver() {
        for button in buttons {
            if button.isEnabled == true {
                jeopardy.gameIsOngoing = true
                break
            }
            
            jeopardy.gameIsOngoing = false
        }
        
        if jeopardy.gameIsOngoing {
            if jeopardy.currentQuestion != nil {
                switchViews()
            }
        } else {
            for subview in self.view.subviews where subview.tag == 0 || subview.tag == 1 {
                subview.isHidden = true
            }
            gameOverMessageLabel.text = "Your score was \(jeopardy.score). Would you like to play again?"
        }
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
                resultsLabel.text = "The correct answer was \"\(jeopardy.answer)\".\n\nCongrats, you got that right 😒"
            case false:
                resultsLabel.text = "The correct answer was \"\(jeopardy.answer)\".\n\nLOL YOU GOT THAT WRONG!!!! 😂"
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
