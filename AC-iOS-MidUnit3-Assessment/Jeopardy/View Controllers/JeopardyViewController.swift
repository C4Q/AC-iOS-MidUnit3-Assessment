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
    
    //Question Screen
    @IBOutlet weak var dailyDoubleLabel: UILabel!
    @IBOutlet weak var betPointsTextField: UITextField!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultsLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var goBackButton: UIButton!
    
    let jeopardy = Jeopardy()
    
    var jeopardyCurrentQuestion: JeopardyQuestion? {
        didSet {
            questionLabel.text = jeopardyCurrentQuestion?.question
            jeopardy.answer = (jeopardyCurrentQuestion?.answer)!
        }
    }
    
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
        sender.isHighlighted = true
        
        let currentCategory = jeopardy.currentCategories[sender.tag]
        
        let currentPoints: Int
        
        switch sender.titleLabel!.text! {
        case "200":
            currentPoints = 200
        case "400":
            currentPoints = 400
        case "600":
            currentPoints = 600
        case "800":
            currentPoints = 800
        case "1000":
            currentPoints = 1000
        default:
            return
        }
        
        let currentQuestionArray = jeopardy.currentQuestions.filter{$0.category == currentCategory && $0.value == currentPoints}
        
        if currentQuestionArray.isEmpty {
            dailyDoubleLabel.isHidden = false
            betPointsTextField.isHidden = false
            
            let nilQuestionArray = jeopardy.currentQuestions.filter{$0.category == currentCategory && $0.value == nil}
            
            if nilQuestionArray.isEmpty {

                return
            } else {
                questionLabel.text = nilQuestionArray[0].question.uppercased()
            }
        } else {
            dailyDoubleLabel.isHidden = true
            betPointsTextField.isHidden = true
            questionLabel.text = currentQuestionArray[0].question.uppercased()
        }
        
        switchViews()
    }
    
    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        currentScoreLabel.text = "CURRENT SCORE: \(jeopardy.score)"
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

extension JeopardyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        
//        jeopardy.checkAnswer(<#T##userAnswer: String##String#>, worthPoints: <#T##Int?#>)
        
        textField.isEnabled = false
        textField.resignFirstResponder()
        return true
    }
}
