//
//  JeopardyGameBrain.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Reiaz Gafar on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

enum Message: String  {
    case right = "Congrats! That was the correct answer!"
    case wrong = "Sorry. That answer was incorrect. The correct answer was"
}

class JeopardyGameBrain {
    var questions: [JeopardyQuestion]
    
    private var counter = 0
    var gameMessage = ""
    var totalValue = 0
    var numberOfRightAnswers = 0
    var numberOfWrongAnswers = 0
    
    func getQuestion() -> JeopardyQuestion {
        if counter >= questions.count {
            counter = 0
        }
        let question = questions[counter]
        counter += 1
        return question
    }
    
    func checkAnswer(answer: String) -> Bool {
        
        let answerArray = answer.components(separatedBy: " ").map(){ $0.lowercased() }
        let isRightAnswer = answerArray.contains(questions[counter - 1].answer.lowercased())
        
        if isRightAnswer {
            if let value = questions[counter - 1].value {
                totalValue += value
                numberOfRightAnswers += 1
                gameMessage = Message.right.rawValue
            }
        } else {
            if let value = questions[counter - 1].value {
                totalValue -= value
                numberOfWrongAnswers += 1
                gameMessage = "\(Message.wrong.rawValue) \"\(questions[counter - 1].answer)\"."
            }
        }
        return isRightAnswer
    }

    
    init(questions: [JeopardyQuestion]) {
        self.questions = questions
    }
    
}
