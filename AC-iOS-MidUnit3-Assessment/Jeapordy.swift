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




//class CategoryWrapper {
//    var title: String
//
//    init(title: String) {
//        self.title = title
//    }
//}
//


class Questions {
    
    //Creating a model for a question
    var question: String
    var answer: String
    var value: Double?
    var title: String
    
    
    init(question: String, answer: String, value: Double?, title: String) {
        self.question = question
        self.answer = answer
        self.value = value
        self.title = title
    }
    /*
     {
     "id":147584,
     "answer":"forensic",
     "question":"This type of science is used to establish facts for a court of law",
     "value":800,
     "airdate":"2014-05-06T12:00:00.000Z",
     "created_at":"2015-01-22T02:34:28.760Z",
     "updated_at":"2015-01-22T02:34:28.760Z",
     "category_id":17039,
     "game_id":4493,
     "invalid_count":null,
     "category":{
     "id":17039,
     "title":"\"for\"mation",
     "created_at":"2015-01-18T18:10:56.332Z",
     "updated_at":"2015-01-18T18:10:56.332Z",
     "clues_count":10
     }
     */
    
    convenience init?(from dict: [String: Any]) {
        let answer = dict["answer"] as? String ?? "Unknown Answer"
        let value = dict["value"] as? Double? ?? 0.0
//        guard let category = dict["category"] as? CategoryWrapper else {return nil}
        guard let question = dict["question"] as? String else {return nil}
        guard let categoryDict = dict["category"] as? [String:Any] else{return nil}
        guard let title = categoryDict["title"] as? String else{return nil}
        
        //self.init(question: question, answer: answer, value: value, category: category)
        self.init(question: question, answer: answer, value: value, title: title)
        
    }
    
    
    static func getQuestions(from data: Data) -> [Questions] {
        var questionArr = [Questions]()
        
        
        //This is like a big if else where you must have an else that is a catch
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = json as? [[String: Any]] else { return [] }
            
            //Iterating through the array of dictionarys  then appending to an array
            for questionDict in jsonDict {
                if let questions = Questions(from: questionDict) {
                    
                    questionArr.append(questions)
                    
              // dump(questionArr)
                }
                
            }
            
        }
        catch {
            print(error)
        }
        
        return questionArr
    }
}



