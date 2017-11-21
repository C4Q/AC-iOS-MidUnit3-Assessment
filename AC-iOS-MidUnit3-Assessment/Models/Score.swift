//
//  Score.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

class Score {
    static var total = 0
    static var numbersOfWin = 0
    static var numbersOfLose = 0
    static var average: Int {
        if total == 0 {
            let result = Double(numbersOfWin) / Double(1)
            return Int(result)
        }
        let result = ((Double(numbersOfWin) / Double(total)) * 100)
        return Int(result)
    }
}
