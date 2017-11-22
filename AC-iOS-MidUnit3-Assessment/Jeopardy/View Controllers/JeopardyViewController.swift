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
        
        if let question = jeopardy.currentQuestion {
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
            if "0123456789".contains(string) || string == "" {
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
            
            jeopardy.betPoints = bet
            
        } else if textField == answerTextField {
            //checking answers
            //        jeopardy.checkAnswer(<#T##userAnswer: String##String#>, worthPoints: <#T##Int?#>)
            
        }
        
        
        currentScoreLabel.text = "CURRENT SCORE: \(jeopardy.score)"
        
        jeopardy.betPoints = 0
        
        textField.isEnabled = false
        textField.resignFirstResponder()
        return true
    }
}
