//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {

    
    var questions = [JeopardyQuestion]()
    
    func nextQuestion() -> String {
        var currentIndex = 0
        var currentQuestion = questions[currentIndex].question
        currentIndex += 1
        if currentIndex == questions.count {
            currentIndex = 0
        }
        return currentQuestion
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

 

}

