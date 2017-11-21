//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Reiaz Gafar on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {
    
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var jeopardyImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreTrackerLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    
    var questions = [JeopardyQuestion]()
    lazy var jeopardy = JeopardyGameBrain(questions: questions)
    lazy var currentQuestion = jeopardy.getQuestion()


    var entryText = "" {
        didSet {
            if jeopardy.checkAnswer(answer: self.entryText) {
                updateLabels()
            } else {
                updateLabels()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.delegate = self
        jeopardyImageView.image = #imageLiteral(resourceName: "jeopardyLogo")
        questions = JeopardyQuestion.getJeopardyQuestions()
        updateLabels()
        answerLabel.isHidden = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Button Actions
    
    @IBAction func nextQuestionButtonTapped(_ sender: UIButton) {
        
        /*
         ENABLE IF YOU WANT THE PRESS TO REGISTER AS A GUESS
     
        if answerTextField.isUserInteractionEnabled {
            entryText = answerTextField.text!
        }
         */
    
        answerTextField.text = ""
        currentQuestion = jeopardy.getQuestion()
        answerTextField.isUserInteractionEnabled = true
        answerLabel.isHidden = true
        updateLabels()
    }
    

}

    // MARK: - TextField

extension JeopardyViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        entryText = textField.text!
        textField.resignFirstResponder()
        textField.isUserInteractionEnabled = false
        answerLabel.isHidden = false
        return true
    }
}

    // MARK: - Helper Functions

extension JeopardyViewController {
    
    func updateLabels() {
        answerLabel.text = currentQuestion.answer
        questionLabel.text = currentQuestion.question
        valueLabel.text = "\(currentQuestion.value ?? 0)"
        categoryLabel.text = currentQuestion.category
        answerLabel.text = jeopardy.gameMessage
        scoreTrackerLabel.text = "Right Answers: \(jeopardy.numberOfRightAnswers) Wrong Answers: \(jeopardy.numberOfWrongAnswers)"
        totalValueLabel.text = "Total Value Accumulated: \(jeopardy.totalValue)"
    }
    
    
}
