//
//  JeopardyData.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class JeopardyData: Codable {
    let jeapardyArr: Jeopards
}
class Jeopards: Codable {
    let category: CategoryWraper
    let value: Int?
    let question: String
    let answer: String
}
class CategoryWraper: Codable {
    let title: String
}

class JeopardsManager {
   var index = 0
   var jeopardsArr = [Jeopards]()
    var score = 0
func getJeopards() -> [Jeopards] {
    if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
        let myUrl = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: myUrl)
            let decoder = JSONDecoder()
            let json = try? decoder.decode([Jeopards].self, from: data)
            if let array = json {
                self.jeopardsArr = array
            }
            
        } catch {
            print(error)
        }
    }
    return self.jeopardsArr
}
    func resetIndex() {
        if index < jeopardsArr.count - 1 {
        index += 1
        } else {
        index = 0
        }
    }
    func ifCorrectAnswer(of input: String) -> Bool {
      let correctArr = jeopardsArr[index].answer.lowercased().split(separator: " ")
     let inputArr = input.split(separator: " ")
        for i in inputArr {
            if !correctArr.contains(i) {
                if let theValue = jeopardsArr[index].value {
                    if score >= theValue {
                    score -= theValue
                    } else {
                        score = 0
                    }
                }
                return false
            }
        }
        if let theValue = jeopardsArr[index].value {
        score += theValue
        }
      return true
    }
    
    
    
}
