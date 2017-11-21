//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {
    
    ///MARK: - Outlets
    @IBOutlet weak var JeopardyLogo: UIImageView!
    @IBOutlet weak var questionTextView: UITextView!
    @IBOutlet weak var userResponseTextField: UITextField!
    @IBOutlet weak var nextQuestionLabel: UIButton!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var whatIsLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    ///MARK: - Instances and Variables
    var jeopardyGame = [JeopardyInfo]()
    //var question = JeopardyQuestion()
    var score = 0
    var currentIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJeopardyData()
        loadJeopardyGame()
        userResponseTextField.delegate = self
    }
    
    func getJeopardyData(){
        //parse data
        guard let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") else {return}
        let myUrl = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: myUrl) else {return}
        let myDecoder = JSONDecoder()
        do{
            //use myDecoder to try and decode the data from the Contacts struct
            let jeopardyInfo = try myDecoder.decode([JeopardyInfo].self, from: data)
            //set that to the contacts instance
            //flatmap the array to get rid of any nils in the data
            self.jeopardyGame = jeopardyInfo.flatMap{$0}
        } catch let error {
            print(error)
        }
    }
    
    func loadJeopardyGame(){
        //messageLabel.isHidden = true
        whatIsLabel.isHidden = false
        whatIsLabel.text = "What is..."
        JeopardyLogo.image = UIImage(imageLiteralResourceName: "jeopardyLogo")
        
        //setting question
        for question in jeopardyGame{
            questionTextView.text = question.question
            if question.value != nil {
                valueLabel.text = "Value: \(String(describing: question.value!))"
            }
            categoryLabel.text = "Category: \(question.category.title.capitalized)"
            scoreLabel.text = "Score: \(0)"
        }
    }
    
    // MARK: - Textfield Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == userResponseTextField {
            userResponseTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {return false}
        if text == userResponseTextField.text {
            
            ///MARK: - Refactor this!
            for answer in jeopardyGame{
                if userResponseTextField.text == answer.answer  {
                    messageLabel.isHidden = false
                    messageLabel.text = "Correct!"
                    if answer.value != nil{
                        scoreLabel.text = "Score: \(score += answer.value!)"
                    } else {
                        messageLabel.isHidden = false
                        messageLabel.text = "Wrong! Correct answer was \(answer.answer)"
                        if answer.value != nil{
                            scoreLabel.text = "Score: \(score -= answer.value!)"
                        }
                    }
                }
            }
            userResponseTextField.resignFirstResponder()
        }
        return true
    }
    
    //MARK: - Button Action
    @IBAction func buttonPressed(_ sender: UIButton) {
        //Go on to the next question
        questionTextView.text = getNextQuestion()
    }
    
    ///MARK: - Put into Model as static method later
    func getNextQuestion() -> String{
        var questionArr : [String] = []
        //appending only questiond to answer array
        for questions in jeopardyGame{
            questionArr.append(questions.question)
        }
        //iterating thru array to return next question
        for _ in 0..<jeopardyGame.count{
            if currentIndex == questionArr.count {
                currentIndex = 0
            } else{
                currentIndex += 1
            }
        }
        return "\(questionArr[currentIndex - 1])"
    }
}//end of class
