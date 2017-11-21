//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Variables
//    var game = JeopardyBrain()
    var jeopardyQuestions = [Jeopardy]()
    var currentGameRound: Int = 0
    
    //MARK: - Outlets
    @IBOutlet weak var jeopardyImageView: UIImageView!
    @IBOutlet var jeopardyLabels: [UILabel]!
    @IBOutlet weak var gameMessageLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    //MARK: - Override ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        getJeopardyData()
        jeopardyQuestionGenerator()
        jeopardyImageView.image = UIImage(named: "jeopardyLogo")
    }
    
    //MARK: - Functions
    func getJeopardyData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let jeopardyQuestions = try myDecoder.decode([Jeopardy].self, from: data)
                    self.jeopardyQuestions = jeopardyQuestions
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    func jeopardyQuestionGenerator(){
        let currentRoundAsIndex = (currentGameRound > jeopardyQuestions.count) ? 0 : currentGameRound
        continueButton.isHidden = true
        gameMessageLabel.isHidden = true
        let newQuestion = jeopardyQuestions[currentRoundAsIndex]
        for label in jeopardyLabels {
            switch label.tag {
            case 0: // category
                label.text = "Category: " + newQuestion.category.title
            case 1: // value
                let value = newQuestion.value ?? 0
                label.text = "Value: " + String(value)
            case 5: // question
                label.text = "Question:\n\(newQuestion.question)"
            default:
                break
            }
        }
    }
    
    func checkAnswer() {
        guard textField.text == jeopardyQuestions[currentGameRound].answer else {
            gameMessageLabel.isHidden = false
            gameMessageLabel.text = "Incorrect! That answer was \(jeopardyQuestions[currentGameRound])"
            continueButton.isHidden = false
            return
        }
        gameMessageLabel.isHidden = false
        gameMessageLabel.text = "Correct!"
        continueButton.isHidden = false
    }
    
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        currentGameRound += 1
        jeopardyQuestionGenerator()
        gameMessageLabel.isHidden = true
    }
    
    
}

