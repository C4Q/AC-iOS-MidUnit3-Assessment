//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var jeopardys = [Jeopards]()
    let model = JeopardsManager()
    var score: Int = 0
    var inputanswer: String?
    var index: Int {
        return model.index
    }
    var ifCorrectAnswer = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var feedBackLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       self.jeopardys = model.getJeopards()
       self.textField.delegate = self
        self.scoreLabel.text = "Total score: \(score)"
        self.imageView.image = #imageLiteral(resourceName: "jeopardyLogo")
       configure()

    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.inputanswer = textField.text
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.inputanswer = textField.text
        guard textField.text != nil, textField.text != "" else {
            self.ifCorrectAnswer = false
            return false
        }
        self.ifCorrectAnswer = model.ifCorrectAnswer(of: textField.text!)
        self.score = model.score
        if ifCorrectAnswer {
            self.scoreLabel.text = "Total score: \(self.score)"
            self.feedBackLabel.isHidden = false
            self.feedBackLabel.text = "Correct!"
            self.feedBackLabel.backgroundColor = .green
            self.textField.isHidden = true
        } else {
            self.scoreLabel.text = "Total score: \(self.score)"
            self.feedBackLabel.isHidden = false
            self.feedBackLabel.text = "Wrong answer!\nThe correct answer is: \(jeopardys[index].answer)"
            self.feedBackLabel.backgroundColor = .red
             self.textField.isHidden = true
        }
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }

    @IBAction func nextButtonPressed(_ sender: UIButton) {
        self.textField.isHidden = false
        model.resetIndex()
        configure()
    }
    func configure() {
        self.categoryLabel.text = jeopardys[index].category.title
        self.questionLabel.text = jeopardys[index].question
        let value = jeopardys[index].value?.description ?? "Unknown"
        self.valueLabel?.text = "Value: \(value)"
        self.feedBackLabel.isHidden = true
    }

}

