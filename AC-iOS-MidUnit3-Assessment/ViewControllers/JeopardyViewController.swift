//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {

    var triviaArray = [Jeopardy]()
    var currentAnswer = ""
    var currentScore = 0
    var counter = 0 {
        didSet {
            if counter == triviaArray.count - 1 {
                counter = 0
            }
        }
    }
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var guessingTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        counter = counter + 1
        loadQuestion()
        messageLabel.text = ""
        guessingTextField.isUserInteractionEnabled = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        loadQuestion()
        guessingTextField.delegate = self
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let trivia = try myDecoder.decode([Jeopardy].self, from: data)
                    self.triviaArray = trivia
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    func loadQuestion() {
        scoreLabel.text = "Score: \(currentScore)"
        currentAnswer = triviaArray[counter].answer
        textView.text = triviaArray[counter].question
        categoryLabel.text = triviaArray[counter].category.title.capitalized
        valueLabel.text = triviaArray[counter].value?.description
    }

}
extension JeopardyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guessingTextField.resignFirstResponder()
        guard let guess = guessingTextField.text else {
            return false
        }
        guessingTextField.text = ""
        if guess.lowercased() == currentAnswer.lowercased() {
            messageLabel.text = "Correct!"
            currentScore += triviaArray[counter].value ?? 0
        } else {
            messageLabel.text = "Answer: \(currentAnswer.capitalized)"
            currentScore -= triviaArray[counter].value ?? 0
        }
        guessingTextField.isUserInteractionEnabled = false
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let characterSet = CharacterSet.letters
        if string.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
}

