//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController, UITextFieldDelegate {

    var jeopardyData = [Jeopardy]().filter { $0.value != (Int("null")) }
//    var nullFreeValues: [Jeopardy] {
//        guard let questions = nullFreeValues.filter { $0. } else {
//            return jeopardyData
//        }
//        return formattedContactsArray.filter { $0.fullName.lowercased().contains(searchTerm.lowercased()) }
//    }
    
    
    //MARK: -Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questionValueLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.delegate = self

    }

    func loadData() {
        let jeopardyInfo = DecodedJSON.getData()
    }

}
