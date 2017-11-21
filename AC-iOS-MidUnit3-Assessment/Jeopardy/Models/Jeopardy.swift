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
    var currentQuestions: [JeopardyQuestion] = []
    var currentCategories: [String] = []
    
    var score: Int = 0
    
    //need to be set when user clicks go
    var answer: String = ""
    
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
    
    //Jeopardy Extra Credit #1 - scores
    func checkAnswer(_ userAnswer: String, worthPoints answerPoints: Int?, bet betPoints: Int = 0) -> Bool {
        //to do - compare to answer - IMPROVE ERROR HANDLING!!
        if answer.contains(userAnswer.lowercased()) && ((userAnswer.count >= answer.count - 2) || (userAnswer.count == answer.count)) {
            score += answerPoints ?? betPoints
            return true
        }
        
        score -= answerPoints ?? betPoints
        return false
    }
    
    //Private Implementation
    private var questions: [JeopardyQuestion] = []
    private var categories: [String] = []
    
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
}
