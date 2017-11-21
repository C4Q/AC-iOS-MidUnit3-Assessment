//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var answerCheckLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var jeopardyGame: JeopardyGame?
    var questions: [Question]?
    var previousQuestions = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.answerCheckLabel.isHidden = true
        // Do any additional setup after loading the view.
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: url) {
                do {
                    let json = try JSONDecoder().decode([Question].self, from: data)
                    self.questions = json
                } catch {
                    print("///////////////////////")
                    print(error)
                    print("///////////////////////")
                }
            }
        }
        guard let questions = questions else {
            return
        }
        jeopardyGame = JeopardyGame(questions: questions)
        loadGame()
    }
    
    func loadGame() {
        guard let jeopardyGame = jeopardyGame else {
            return
        }
        self.scoreLabel.text = "Score: \(jeopardyGame.points)"
        guard !jeopardyGame.noMoreQuestions() else {
            self.questionLabel.text = "no more questions"
            self.categoryLabel.text = "no more questions"
            self.valueLabel.text = "no more questions"
            self.answerCheckLabel.text = "no more questions"
            self.answerCheckLabel.isHidden = false
            return
        }
        
        self.questionLabel.text =  jeopardyGame.getSelectedQuestion().question
        self.categoryLabel.text = "Category\n" +  jeopardyGame.getSelectedQuestion().category.title
        if let value = jeopardyGame.getSelectedQuestion().value {
            self.valueLabel.text = "Value\n" +  String(value)
        } else {
            self.valueLabel.text = ""
        }
        //questions.forEach{print($0.question)}
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func nextQuestionPlease(_ sender: UIButton) {
        if !(jeopardyGame?.noMoreQuestions())! {
            jeopardyGame?.setNextQuestion()
            self.textField.isEnabled = true
            self.textField.text = ""
        } else {
            self.textField.text = "no more questions"
        }
        self.answerCheckLabel.isHidden = true
        self.textField.backgroundColor = UIColor.white
        
        
        loadGame()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension JeopardyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let jeopardyGame = jeopardyGame, let guess = textField.text else {
            return false
        }
        if jeopardyGame.isAnswer(userAnswer: guess) {
            jeopardyGame.addPoints()
            self.textField.backgroundColor = UIColor.green
            self.answerCheckLabel.text = "Correct!"
        } else {
            jeopardyGame.subtractPoints()
            self.textField.backgroundColor = UIColor.red
            self.answerCheckLabel.text = "Wrong!"
        }
        self.textField.isEnabled = false
        loadGame()
        return true
    }
}

