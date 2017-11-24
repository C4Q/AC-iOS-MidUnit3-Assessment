//
//  jeopardyModel.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct Question: Codable {
    var answer: String
    var question: String
    var value: Int?
    var category: CategoryWrapper
}

struct CategoryWrapper: Codable {
    var title: String
}

class JeopardyGame {
    private var questions: [Question]
    private var selectedQuestion: Question
    private var answered: Bool = false
    var points: Int = 0
    
    init(questions: [Question]) {
        self.questions = questions
        self.selectedQuestion = questions[0]
        setNextQuestion()
    }
    
    func setNextQuestion() {
        let randex = Int(arc4random_uniform(UInt32(questions.count)))
        selectedQuestion = questions[randex]
        if self.answered {
            self.questions.remove(at: randex)
        }
        self.answered = false
    }
    
    func getSelectedQuestion() -> Question {
        return selectedQuestion
    }
    //removes things like 'a', 'the', etc., and punctuation
    private func removeTrash(string: String) -> String {
        var string = string.lowercased()
        //remove punctuation
        string = String(Array(string).map{CharacterSet.punctuationCharacters.contains(Unicode.Scalar(String($0))!) ? " " : $0})
        
        //remove 'the' and 'a'
        var stringArr = string.components(separatedBy: " ")
        stringArr = stringArr.filter{$0 != "the" && $0 != "a"}
        string = stringArr.reduce(""){$0 + $1}
        if string.first == " " {
            string.removeFirst()
        }
        if string.last == " " {
            string.removeLast()
        }
        return string
    }
    
    func isAnswer(userAnswer: String) -> Bool {
        self.answered = true

        let answerGiven = removeTrash(string: userAnswer)
        let trueAnswer = removeTrash(string: selectedQuestion.answer)
        
        return answerGiven == trueAnswer
    }
    
    func noMoreQuestions() -> Bool {
        return questions.isEmpty
    }
    
    func addPoints() {
        self.points += selectedQuestion.value ?? 0
    }
    
    func subtractPoints() {
        self.points -= selectedQuestion.value ?? 0
    }
}


