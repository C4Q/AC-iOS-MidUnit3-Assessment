//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var jeopardyTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nextQButton: UIButton!
    @IBOutlet weak var questionTextView: UITextView!
    
    
    var jeopardy = [Jeopardy]()
    var qAndADictionary = [[String:String]]()
    var currentQuestion = String()
    var currentAnswer = String()
    var currentValue: Int? = nil
    var currentCategory: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jeopardyTextField.delegate = self
        loadData()
        setUpJeopardy()
    }
    
    
    var counter = 0
    func setUpJeopardy () {
        //        questionTextView.text = currentQuestion
        counter += 1
        for currentSpot in 0...jeopardy.count - 1 {
            if counter == currentSpot {
                currentQuestion = jeopardy[currentSpot].question
                currentAnswer = jeopardy[currentSpot].answer
                currentValue = jeopardy[currentSpot].value
                currentCategory = jeopardy[currentSpot].category.title
            }
        }
        if counter == jeopardy.count {
            counter = 0
        }
        setUpLabels()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        if text.lowercased() == currentAnswer.lowercased() {
            messageLabel.text = "That is correct!"
        }
        else {
            messageLabel.text = "Wrong, the answer was \(currentAnswer)"
        }
        return false
    }
    
    
    @IBAction func nextQuestionButtonPressed(_ sender: UIButton) {
        
        //        questionTextView.text = currentQuestion
        //        jeopardyTextField.text = ""
        //        categoryLabel.text = currentCategory
        //        if let unwrappedValue = currentValue {
        //            valueLabel.text = String(unwrappedValue)
        //        }
        //        messageLabel.text = ""
        setUpJeopardy()
    }
    
    
    func setUpLabels() {
        questionTextView.text = currentQuestion
        categoryLabel.text = currentCategory
        messageLabel.text = ""
        jeopardyTextField.text = ""
        if let unwrappedValue = currentValue {
            valueLabel.text = String(unwrappedValue)
        }
    }
    
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let jeopardyDecoder = JSONDecoder()
                do {
                    let jeopardy = try jeopardyDecoder.decode([Jeopardy].self, from: data)
                    self.jeopardy = jeopardy
                }
                catch let error {
                    print(error)
                }
            }
            
        }
        
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
