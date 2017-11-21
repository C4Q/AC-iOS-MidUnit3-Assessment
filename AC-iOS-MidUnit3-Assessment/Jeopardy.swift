//
//  Jeopardy.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation

typealias JeopardyAlias = Jeopardy

struct Jeopardy: Codable {
    let question: String //should be already loaded. Place in viewDidLoad/viewWillAppear
    let answer: String //place in message text label
    let value: Int?
    let category: Categories
}
//
struct Categories: Codable {
    let title: String
}



/*
 [
 {
 "id":147545,
 "answer":"dressed",
 "question":"Added ranch to the greens, or plucked the bird for cooking",
 "value":600,
 "airdate":"2014-05-07T12:00:00.000Z",
 "created_at":"2015-01-22T02:34:26.632Z",
 "updated_at":"2015-01-22T02:34:26.632Z",
 "category_id":17033,
 "game_id":4496,
 "invalid_count":null,
 "category":{
 "id":17033,
 "title":"from \"d\" to dining \"d\"",
 "created_at":"2015-01-18T18:10:54.521Z",
 "updated_at":"2015-01-18T18:10:54.521Z",
 "clues_count":10
 }
 }]
 
 Requirements:
 
 The first tab is comprised of a single View Controller which should have:
 
 An image with the Jeopardy logo included in your Assets.xcassets folder.
 A text label to represent the Category
 A text label to represent the Value (How many points the question was worth on the show)
 A text field where the user can input their answer
 A text label representing the message the user will recieve after guessing a word
 A button to go to the next question
 Details
 
 When the view loads, a question should already by loaded for the user to view. When the user presses return after inputing a guess to the text field, a message should display.
 
 The message should tell the user whether or not they guessed correctly and display the correct answer if they guessed wrong.
 
 You should be comparing the user's guess against the correct answer case insensitively. Don't worry about the user getting it wrong because of a slight difference between their answer and the correct answer. For example, it's fine if the user gets it wrong when entering "foray" when the correct answer is "a foray".
 
 Extra Credit opportunities:
 
 Add a score tracker. Guessing wrong should subtract that many points from your score.
 Add better handling for matching the user's input to the correct answer.
 */



