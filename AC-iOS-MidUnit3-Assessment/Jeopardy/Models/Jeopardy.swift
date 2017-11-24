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
        if answer.lowercased().contains(userAnswer.lowercased()) && ((userAnswer.count >= answer.count - 2) || (userAnswer.count == answer.count)) {
            //Jeopardy Extra Credit #1 - scores
            score += (currentQuestion?.value) ?? (betPoints * 2)
            return true
        }
        
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
