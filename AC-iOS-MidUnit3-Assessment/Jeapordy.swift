//
//  Jeapordy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Ashlee Krammer on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation


//
//struct Jeopardy: Codable {
//    var answer: String?
//    var question: String
//    var value: Int?
//    var category: CategoryWrapper
//
//}
//
//struct CategoryWrapper:  Codable{
//    var title: String
//    }




class CategoryWrapper {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}



class Questions {
    
    //Creating a model for a question
    var question: String
    var answer: String
    var value: Double?
    var category: CategoryWrapper
    
    
    init(question: String, answer: String, value: Double?, category: CategoryWrapper) {
        self.question = question
        self.answer = answer
        self.value = value
        self.category = category
    }
    
    convenience init?(from dict: [String: Any]) {
        let answer = dict["answer"] as? String ?? "Unknown Answer"
        let value = dict["value"] as? Double? ?? 0.0
        guard let category = dict["category"] as? CategoryWrapper else {return nil}
        guard let question = dict["question"] as? String else {return nil}
        self.init(question: question, answer: answer, value: value, category: category)
        
    }
    
    
    func getQuestions(from data: Data) -> [Questions] {
        var questionArr = [Questions]()
        
        
        //This is like a big if else where you must have an else that is a catch
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = json as? [[String: Any]] else { return [] }
            
            //Iterating through the array of dictionarys  then appending to an array
            for questionDict in jsonDict {
                if let questions = Questions(from: questionDict) {
                    
                    questionArr.append(questions)
                }
                
            }
            
        }
        catch {
            print(error)
        }
        
        return questionArr
    }
}



