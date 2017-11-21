//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        loadData()
        setup(questions: questions)
    }
    
    var questions = [QuestionModel]()
    var currentQuestion : QuestionModel?
    var currentScore = 0
    
    @IBOutlet weak var nextQuestionButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionValueLabel: UILabel!
    @IBOutlet weak var questionLabel: UITextView!
    
    // realized textview would be better but wanted to keep the name so I didnt have to alter too much code
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
  
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json"){
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL){
                let myDecoder = JSONDecoder()
                do {
                  questions = try myDecoder.decode([QuestionModel].self, from: data)
                    
                }catch{
                    print(error)
                }
            }
        }
    }
    

    func setup(questions: [QuestionModel]){
        var randomNum = arc4random_uniform(UInt32(questions.count))
        var randomIndex = Int(randomNum)
        
       while questions[randomIndex].value == nil {
        randomNum = arc4random_uniform(UInt32(questions.count))
        randomIndex = Int(randomNum)
        }
        
        currentQuestion = questions[randomIndex]
        questionLabel.text = currentQuestion!.question
        questionValueLabel.text? = (questions[randomIndex].value?.description)!
        categoryLabel.text = questions[randomIndex].category.title
}
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let guess = textField.text
        
        if currentQuestion?.answer.lowercased() == guess?.lowercased(){
            resultLabel.isHidden = false
            resultLabel.text = "Correct!"
            textField.isHidden = true
            currentScore += (currentQuestion?.value)!
            scoreLabel.text = "Score: " + currentScore.description
            nextQuestionButton.isHidden = false
            textField.text = ""
            
        } else{
            resultLabel.isHidden = false
            resultLabel.text = "Wrong! the right answer was: " + (currentQuestion?.answer)!
            textField.isHidden = true
            currentScore -= (currentQuestion?.value)!
            scoreLabel.text = "Score: " + currentScore.description
            nextQuestionButton.isHidden = false
            textField.text = ""
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func nextQuestionPressed(_ sender: UIButton) {
        nextQuestionButton.isHidden = true
        textField.isHidden = false
        resultLabel.isHidden = true
        setup(questions: questions)
    }
    
    
}
