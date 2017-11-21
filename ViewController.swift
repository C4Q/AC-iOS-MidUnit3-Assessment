//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    var jeopardyinfo = [JeopardyInfo]()
    var jeopardys = [JeopardyWrapper]()
    var jdetails : JeopardyWrapper!
    var categorydetail = [CategoryWrapper]()
    var questions = [String]()
    var values = [Int?]()
    var answers = [String]()
    var randNum = 0
    var categories = [String]()
    var guess = ""
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
//    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        loadData()
        newQuestion()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    //outer wrapper
                    let jeopardys = try myDecoder.decode([JeopardyWrapper].self, from: data)
                    //inner wrapper
                    self.jeopardys = jeopardys
                   
                  
                    
                }catch let error{
                    print(error)
                }
            }
        }

        for question in jeopardys {
            questions.append(question.question!)
        }
        //print(questions)
        print(questions.count)
        for value in jeopardys {
           
            values.append(value.value)
        }
        print("\(values.count)values")
        //print(questions[0])
        //print(questions[88])
        //array of 0-88
      
        for category in jeopardys {
        categories.append(category.category.title!)
        }
        
        for answer in jeopardys {
            answers.append((answer.answer?.lowercased())!)
        }
        //print("\(answers.count) answers")
        //print(answers)
    }
    func newQuestion() {
        randNum = Int(arc4random_uniform(UInt32(88)))
        //print("\(randNum)")
         questionLabel.text = questions[randNum]
         categoryLabel.text = categories[randNum]
        resultLabel.text = "guess!"
        textField.text = ""
        if randNum > 0{
            valueLabel.text = "\(String(describing: values[randNum])) points"
        }else {
            valueLabel.text = "nil points"
        }
       // print(questions[randNum])
        //print(categories[randNum])
        //print("answer \(answers[randNum])")
       // print(values[randNum]!)
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
     newQuestion()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guess = textField.text!.lowercased()
       // print(guess)
        if guess.contains(answers[randNum]) || guess == answers[randNum] {
            resultLabel.text = "Correct!"
        } else {
            resultLabel.text = "Wrong! The answer is \(answers[randNum])"
        }
        
        textField.resignFirstResponder()
        return true
    }

}

