//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Masai Young on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {

    var questions: [JeopardyQuestion]?
    var randomQuestion: JeopardyQuestion?
    var score = 0
    
    @IBOutlet weak var jeopardyImageView: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var correctnessLabel: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var userInputField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBAction func nextPressed(_ sender: Any) {
        randomQuestion = JeopardyQuestion.randomQuestion(from: questions!)
        setUp()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInputField.delegate = self
        questions = JeopardyQuestion.fetchQuestions()
        randomQuestion = JeopardyQuestion.randomQuestion(from: questions!)
        print(randomQuestion?.answer)
        setUp()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUp() {
        jeopardyImageView.image = #imageLiteral(resourceName: "jeopardyLogo")
        questionLabel.text = randomQuestion?.question
        valueLabel.text = randomQuestion?.value?.description ?? "No value"
        category.text = randomQuestion?.category.title
        userInputField.isEnabled = true
        correctnessLabel.isHidden = true
    }
    
    func updateScore() {
        scoreLabel.text = "Score: \(score) || " 
    }
    
    func showIfWon(won: Bool) {
        correctnessLabel.isHidden = false

        switch won {
        case true:
            correctnessLabel.text = "Correct"
            correctnessLabel.textColor = UIColor(red:0.16, green:0.63, blue:0.31, alpha:1.00)
            score += randomQuestion!.value ?? 0
        case false:
            correctnessLabel.text = "Incorrect. Answer is " + (randomQuestion?.answer ?? "No Answer")
            correctnessLabel.textColor = UIColor(red:0.73, green:0.07, blue:0.11, alpha:1.00)
            score -= randomQuestion!.value ?? 0
        }
        updateScore()
    }

}

extension JeopardyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard !(textField.text?.isEmpty)! else { return false }
        if randomQuestion?.answer.range(of: textField.text!, options: .caseInsensitive) != nil {
            showIfWon(won: true)
            
        } else {
            showIfWon(won: false)
        }
        textField.text?.removeAll()
        textField.isEnabled = false
        return true
    }
}
