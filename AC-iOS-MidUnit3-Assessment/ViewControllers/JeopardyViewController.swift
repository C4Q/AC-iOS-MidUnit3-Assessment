//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {
    var allQuestions = [Questions]()
    var randomValue: Questions?
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var messageCorrectOrWrong: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var questionBox: UITextView!
    @IBOutlet weak var logoImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInput.delegate = self
        logoImage.image = #imageLiteral(resourceName: "jeopardyLogo")
       loadData()
        nextQuestion(UIButton())
        
        
    }
    //MARK - methods
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
    
                do {
                   let question = try myDecoder.decode([Questions].self, from: data)
                        self.allQuestions = question
                }
                catch {
                    print(error)
                }
            }
        }
      
       
    }
    //MARK - TEXTFIELD Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if userInput?.text != nil && (textField.text?.contains(randomValue!.answer!))! {
//
        if userInput?.text != nil && randomValue!.answer!.lowercased().contains(textField.text!.lowercased()) {
               textField.resignFirstResponder()
            messageCorrectOrWrong.text = "correct answer"
           
         
            
        }
        else {
            messageCorrectOrWrong.text = "wrong answer"
            textField.resignFirstResponder()
            
        }
      
return true
    }

    
    func randomNumber() -> UInt32 {
        let A: UInt32 = 0 // UInt32 = 32-bit positive integers (unsigned)
        let B: UInt32 = UInt32(allQuestions.count - 1)
        let number = arc4random_uniform(B - A + 1) + A
        return number
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    //MARK - Button
    var index = 0
    @IBAction func nextQuestion(_ sender: UIButton) {
        randomValue = allQuestions[Int(randomNumber())]
        questionBox.text = randomValue?.question
        category.text = randomValue?.category.title
        value.text = randomValue?.value?.description
     
}



}
