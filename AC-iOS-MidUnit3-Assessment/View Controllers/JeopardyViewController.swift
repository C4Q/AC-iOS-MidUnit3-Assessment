//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {

    var arrJeopardy = [Jeopardy]()
    var index = 0
    //var scoreUser = Score()
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var txtInputUser: UITextField!
    @IBOutlet weak var lblAnswer: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtInputUser.delegate = self
        loadJeopardyData()
        loadlabels()
    }

    
    @IBAction func btnNextQUestion(_ sender: UIButton) {
        if self.index < self.arrJeopardy.count - 1 {
            self.index += 1
        } else {
            self.index = 0
        }
        loadlabels()
    }
    
    func loadJeopardyData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let jeopardyDecoded = try myDecoder.decode([Jeopardy].self, from: data)
                    self.arrJeopardy = jeopardyDecoded
                } catch let error {
                    print("Unexpeted error:", error)
                    return
                }
            }
        }
    }
    
    func loadlabels() {
        self.lblAnswer.isHidden = true
        self.lblAnswer.textColor = .black
        self.txtInputUser.isEnabled = true
        self.txtInputUser.text = ""
        self.txtInputUser.becomeFirstResponder()
        if self.arrJeopardy.count > 0 {
            let jeopardy = self.arrJeopardy[self.index]
            self.lblCategory.text = "Category: \n \(jeopardy.category.title)"
            let value = jeopardy.value ?? 0
            self.lblValue.text = "Points: \n \(value)"
            self.lblQuestion.text = "Question: \n \(jeopardy.question)?"
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.lblAnswer.isHidden = false
        self.lblScore.isHidden = false
        Score.total += 1
        let secretWord = arrJeopardy[index].answer.lowercased()
        let guessedWord = textField.text?.lowercased() ?? ""
        if fuzzyLookup(guessedWord, secretWord, 0.8) {
            Score.numbersOfWin += 1
            self.lblAnswer.text = "Great you guessed: \n \(arrJeopardy[index].answer)"
        } else {
            Score.numbersOfLose += 1
            lblAnswer.textColor = .red
            self.lblAnswer.text = "Sorry the correct answer is: \n \(arrJeopardy[index].answer)"
        }
        self.lblScore.text = "Wons: \(Score.numbersOfWin) \n Losts: \(Score.numbersOfLose) \n Average: \(Score.average)% \n Total: \(Score.total)"
        txtInputUser.isEnabled = false
        return true
    }
    
    func fuzzyLookup(_ guessWord: String, _ secretWord: String, _ porcApprox: Double) -> Bool {
        var matches = 0
        var total = 0
        let arrGuessWord = guessWord.split(separator: " ")
        let arrSecretWord = secretWord.split(separator: " ")
        for secretValue in arrSecretWord {
            total += secretValue.count
            for word in arrGuessWord {
                if secretValue.contains(word) {
                    matches += secretValue.count
                }
            }
        }
        if (Double(matches) / Double(total)) >= porcApprox {
            return true
        } else {
            return false
        }
    }

}
