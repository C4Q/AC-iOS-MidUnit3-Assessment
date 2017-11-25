//
//  JeopardyModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Clint Mejia on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class JeopardyBrain {
    
    enum Answer: String {
        case correct = "Correct! Try another question."
        case incorrect = "Incorrect! The answer was"
    }
    
    // dictates whether certain labels are hidden
    enum HiddenState: String {
        case yes = "true"
        case no = "false"
    }
    
    //MARK: - Variables
    private var currentGameRound = 0
    private var jeopardyQuestions: [Jeopardy] = []
    var currentRoundInfo: Jeopardy?
    var totalAccumalatedScore = 0
    var hideUI = HiddenState.yes
    private var answerState: Answer?
    var gameMessage: String {
        guard let message = answerState?.rawValue, let answer = currentRoundInfo?.answer else { return "" }
        return (answerState == .correct) ? message : "\(message) \(answer)."
    }
    private var jsonFileName: String {
        didSet { jeopardyQuestions = MyJSONParser().getData(from: jsonFileName)
        }
    }
    init(jsonFileName: String) {
        self.jsonFileName = jsonFileName
        defer { self.jsonFileName = jsonFileName } // defer activates variable jsonFileName didSet
    }
    
    // MARK: - Functions
    private func jeopardyQuestionGenerator() {
        let currentRoundAsIndex = (currentGameRound > jeopardyQuestions.count) ? 0 : currentGameRound
        currentRoundInfo = jeopardyQuestions[currentRoundAsIndex]
    }
    
    // compare answer with text
    func compareAnswerWith(entered text: String) -> Bool {
        currentGameRound += 1
        guard let answer = currentRoundInfo?.answer, answer.lowercased() == text.lowercased() else {
            answerState = Answer.incorrect
            tallyScore()
            hideUI = .no
            return false
        }
        answerState = Answer.correct
        tallyScore()
        hideUI = .no
        return true
    }
    
    // setup a new game
    func setupJeopardy() {
        jeopardyQuestionGenerator()
        hideUI = .yes
    }
    
    // score keeper
    private func tallyScore(){
        let currentQuestionValue = currentRoundInfo?.value ?? 0
        totalAccumalatedScore = (answerState == .correct) ? (totalAccumalatedScore + currentQuestionValue) : (totalAccumalatedScore - currentQuestionValue)
    }
}




