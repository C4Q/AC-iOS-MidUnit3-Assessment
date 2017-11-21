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
        for question in allQuestions {
            print(question.question)
        }
       
    }
    //MARK - TEXTFIELD Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    
    //MARK - Button
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        
    }
    
}


 

