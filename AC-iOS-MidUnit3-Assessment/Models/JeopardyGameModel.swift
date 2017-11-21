//
//  JeopardyGameModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Luis Calle on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class JeopardyGameModel {
    
    private var gameQuestions: [Question]
    private var randomNum: Int
    private static var score: Int = 0
    
    init(questions: [Question]) {
        self.gameQuestions = questions
        randomNum = Int(arc4random_uniform(UInt32(gameQuestions.count)))
    }
    convenience init(){
        self.init(questions: [])
    }
    
    func addQuestions(questions: [Question]) {
        self.gameQuestions = questions
    }
    
    func getRandomQuestion() -> Question {
        var newRandomNum: Int
        repeat {
            newRandomNum = Int(arc4random_uniform(UInt32(gameQuestions.count)))
        } while newRandomNum == randomNum
        self.randomNum = newRandomNum
        let randomQuestion = gameQuestions[randomNum]
        return randomQuestion
    }
    
    func addScore(value: Int) {
        JeopardyGameModel.score += value
    }
    
    func subtractScore(value: Int) {
        JeopardyGameModel.score -= value
    }
    
    func getScore() -> String {
        if JeopardyGameModel.score >= 0 {
            return "$\(JeopardyGameModel.score)"
        } else {
            return "-$\(abs(JeopardyGameModel.score))"
        }
    }
    
}
