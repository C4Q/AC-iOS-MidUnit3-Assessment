//
//  Books.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Ashlee Krammer on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation






class Books {

    //Creating a model for a question
    var title: String
    var author: String
    var subtitle: String?
    var description: String
    var price: Double


    init(title: String, author: String, subtitle: String?, description: String, price: Double) {
        self.title = title
        self.author = author
        self.subtitle = subtitle
        self.description = description
        self.price = price
    }
}
//
//
//    convenience init?(from dict: [String: Any]) {
//        let answer = dict["answer"] as? String ?? "Unknown Answer"
//        let value = dict["value"] as? Double? ?? 0.0
//        //        guard let category = dict["category"] as? CategoryWrapper else {return nil}
//        guard let question = dict["question"] as? String else {return nil}
//        guard let categoryDict = dict["category"] as? [String:Any] else{return nil}
//        guard let title = categoryDict["title"] as? String else{return nil}
//
//        //self.init(question: question, answer: answer, value: value, category: category)
//        self.init(question: question, answer: answer, value: value, title: title)
//
//    }
//
//
//    static func getQuestions(from data: Data) -> [Questions] {
//        var questionArr = [Questions]()
//
//
//        //This is like a big if else where you must have an else that is a catch
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            guard let jsonDict = json as? [[String: Any]] else { return [] }
//
//            //Iterating through the array of dictionarys  then appending to an array
//            for questionDict in jsonDict {
//                if let questions = Questions(from: questionDict) {
//
//                    questionArr.append(questions)
//
//                    // dump(questionArr)
//                }
//
//            }
//
//        }
//        catch {
//            print(error)
//        }
//
//        return questionArr
//    }
//}





//struct AuthorWrapper: Codable {
//    var authors: [String]
//}


//{
//    "kind": "books#volumes",
//    "totalItems": 2308,
//    "items": [
//    {
//    "kind": "books#volume",
//    "id": "UN1RKjs6E8YC",
//    "etag": "p4gBW50aAxQ",
//    "selfLink": "https://www.googleapis.com/books/v1/volumes/UN1RKjs6E8YC",
//    "volumeInfo": {
//    "title": "Nation",
//    "authors": [
//    "Terry Pratchett"
//    ],
//    "publisher": "Harper Collins",
//    "publishedDate": "2009-10-06",
//    "description": "When a giant wave destroys his village, Mau is the only one left. Daphne—a traveler from the other side of the globe—is the sole survivor of a shipwreck. Separated by language and customs, the two are united by catastrophe. Slowly, they are joined by other refugees. And as they struggle to protect the small band, Mau and Daphne defy ancestral spirits, challenge death himself, and uncover a long-hidden secret that literally turns the world upside down.",
//    "industryIdentifiers": [
//    {
//    "type": "ISBN_13",
//    "identifier": "9780061975233"
//    },
//    {
//    "type": "ISBN_10",
//    "identifier": "0061975230"
//    }
//    ],
//    "readingModes": {
//    "text": true,
//    "image": false
//    },

