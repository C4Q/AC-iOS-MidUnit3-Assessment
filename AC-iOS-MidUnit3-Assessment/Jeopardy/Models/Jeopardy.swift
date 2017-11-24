//
//  Jeopardy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Jeopardy {
    //Public API
    var gameIsOngoing = true
    var currentQuestions: [JeopardyQuestion] = []
    var currentCategories: [String] = []
    var currentQuestion: JeopardyQuestion?
    var currentQuestionPoints: Int = 0
    var currentCategory: String = "" {
        didSet {
            getQuestionAndAnswer()
        }
    }
    
    var answer: String = ""
    
    //scoring
    var betPoints: Int = 0
    var score: Int = 0
    
    init() {
        let apiManager = APIManager()
        apiManager.getData(forResource: "jeopardyinfo", ofType: "json") { (data: Data?) in
            
            guard let data = data else {
                print("Error: could not get data from json file.")
                return
            }
            
            let questions = JeopardyQuestion.getJeopardyData(from: data)
            self.questions = questions
            
            for question in questions {
                if !self.categories.contains(question.category) {
                    self.categories.append(question.category)
                }
            }
            
            self.getCurrentGame()
        }
    }
    
    func checkAnswer(_ userAnswer: String) -> Bool {
        //Jeopardy Extra Credit #2 - error handling
        var allowedAnswer = answer.lowercased()
        
        var answerStringArray = Array(allowedAnswer.characters).map{String($0)}
        
        //changing letters with accents marks to allow non-accented answers
        let accentDict = ["á" : "a",
                          "é" : "e",
                          "í" : "i",
                          "ó" : "o",
                          "ú" : "u"]
        
        for index in 0..<answerStringArray.count {
            let currentLetter = answerStringArray[index]
            
            if let regularLetter = accentDict[currentLetter] {
                answerStringArray[index] = regularLetter
            }
        }
        
        //removing "a " and "the " from answers
        if answerStringArray.count > 4 {
            if answerStringArray[0..<2].joined() == "a " {
                allowedAnswer = answerStringArray[2...].joined()
            } else if answerStringArray[0..<4].joined() == "the " {
                allowedAnswer = answerStringArray[4...].joined()
            }
        }
        
        if allowedAnswer == userAnswer.lowercased() {
            //Jeopardy Extra Credit #1 - scores
            score += (currentQuestion?.value) ?? (betPoints * 2)
            return true
        }
        
        //Jeopardy Extra Credit #1 - scores
        score -= (currentQuestion?.value) ?? (betPoints * 2)
        return false
    }
    
    //Private Implementation
    private var questions: [JeopardyQuestion] = []
    private var categories: [String] = []
    private var usedQuestions: [String] = []
    
    private func getCurrentGame() {
        //get current categories
        while currentCategories.count < 6 {
            let randomIndex = Int(arc4random_uniform(UInt32(categories.count)))
            let randomCategory = categories[randomIndex]
            if !currentCategories.contains(randomCategory) {
                currentCategories.append(randomCategory)
            }
        }
        
        //get current questions
        for question in questions {
            if currentCategories.contains(question.category) {
                currentQuestions.append(question)
            }
        }
    }
    
    private func getQuestionAndAnswer() {
        //get question/answer for user depending on which button is pressed
        let currentQuestionArray = currentQuestions.filter{$0.category == currentCategory && $0.value == currentQuestionPoints}
        
        if currentQuestionArray.isEmpty {
            //look for questions with nil value
            let nilQuestionArray = currentQuestions.filter{$0.category == currentCategory && $0.value == nil && $0.question != ""}
            
            if nilQuestionArray.isEmpty || usedQuestions.contains(nilQuestionArray[0].question) {
                currentQuestion = nil
                return
            } else {
                usedQuestions.append(nilQuestionArray[0].question)
                currentQuestion = nilQuestionArray[0]
                answer = nilQuestionArray[0].answer
            }
        } else {
            currentQuestion = currentQuestionArray[0]
            answer = currentQuestionArray[0].answer
        }
    }
    
}
