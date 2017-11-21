//
//  Jeopardy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Masai Young on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

struct JeopardyQuestion: Codable {
    let airdate: String
    let answer: String
    let category: Category
    let category_id: Int
    let created_at: String
    let game_id: Int
    let id: Int
    let invalid_count: String?
    let question: String
    let updated_at: String
    let value: Int?
    
    static func fetchQuestions() -> [JeopardyQuestion]? {
        
        var questions: [JeopardyQuestion]?
        
        guard let filePath = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") else { return nil }
        let myUrl = URL(fileURLWithPath: filePath)
        if let data = try? Data(contentsOf: myUrl) {
            do {
                questions = try JSONDecoder().decode([JeopardyQuestion].self, from: data)
            } catch {
                print(error)
            }
        }
        return questions
    }
    
    static func randomQuestion(from list: [JeopardyQuestion]) -> JeopardyQuestion {
        let count = list.count
        let randomNumber = Int(arc4random_uniform(UInt32(count)))
        return list[randomNumber]
    }
}

struct Category: Codable {
    let clues_count: Int
    let created_at: String
    let id: Int
    let title: String
    let updated_at: String
}




