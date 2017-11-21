//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {
    
    var jeopardyGameInfo: [JeopardyMaterial] = []
    
    @IBOutlet weak var jeopardyLogo: UIImageView!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func responseTextField(sender: AnyObject) {
        if String(sender.value) == jeopardyGameInfo.first!.answer {
            messageLabel.text = "Correct!"
        } else {
            messageLabel.text = "Incorrect!"
        }
    }
    
    let randomIndex = Int(arc4random_uniform(UInt32(100)))
    
    @IBAction func nextQuestionButton(_ sender: UIButton) {
        questionLabel.text = jeopardyGameInfo.first!.question
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        questionLabel.text = jeopardyGameInfo.first!.question
        categoryLabel.text = jeopardyGameInfo.first!.category.title
        pointsLabel.text = jeopardyGameInfo.first!.value?.description
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                do {
                    self.jeopardyGameInfo = try JSONDecoder().decode([JeopardyMaterial].self, from: data)
                }
                catch {
                    print("Error Decoding Data")
                    print(error)
                }
            }
        }
    }
    
    
}

