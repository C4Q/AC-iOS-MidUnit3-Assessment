//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var totalPointsLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var myJeopardy: Jeopardy!
    var jeopardy = [Jeopardy]()

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        loadData()
        setupUI()
        textField.isEnabled = true
        correctAnswerLabel.isHidden = true
    }

    @IBAction func nextQuestionButtonPressed(_ sender: UIButton) {
        if Jeopardy.counter != jeopardy.count - 1 {
            Jeopardy.counter += 1
        } else if Jeopardy.counter == jeopardy.count - 1 {
            Jeopardy.counter = 0
        }
        setupUI()
        textField.text = ""
        textField.isEnabled = true
        correctAnswerLabel.isHidden = true
    }
    
    func setupUI() {
        questionLabel.text = jeopardy[Jeopardy.counter].question
        correctAnswerLabel.text = "Answer: \(jeopardy[Jeopardy.counter].answer)"
        valueLabel.text = "\(jeopardy[Jeopardy.counter].value != nil ? "Value: \(jeopardy[Jeopardy.counter].value!)" : "N/A")"
        categoryLabel.text = "Category: \(jeopardy[Jeopardy.counter].categoryTitle)"
        totalPointsLabel.text = "Total Points: \(Jeopardy.points)"
        correctAnswerLabel.isHidden = true

    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let questions = Jeopardy.createArrayOfQuestions(from: data)
                self.jeopardy = questions!
            }
        }
        for question in jeopardy {
            print(question.question)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }
        if text.lowercased() == jeopardy[Jeopardy.counter].answer.lowercased() {
            if Jeopardy.counter != jeopardy.count - 1 {
                Jeopardy.counter += 1
                Jeopardy.points += jeopardy[Jeopardy.counter - 1].value != nil ? jeopardy[Jeopardy.counter - 1].value! : 0
                ProgressHUD.showSuccess("Correct!")
                setupUI()
                
            } else if Jeopardy.counter == jeopardy.count - 1 {
                Jeopardy.counter = 0
            }
        }
        else {
            Jeopardy.points -= jeopardy[Jeopardy.counter].value != nil ? jeopardy[Jeopardy.counter].value! : 0
            textField.isEnabled = false
            correctAnswerLabel.isHidden = false
            ProgressHUD.showError("Incorrect!")
        }
        textField.text = ""
        totalPointsLabel.text = "Total Points: \(Jeopardy.points)"
        resignFirstResponder()
        return true
    }
}





















