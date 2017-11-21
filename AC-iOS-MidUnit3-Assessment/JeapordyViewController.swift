//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeapordyViewController: UIViewController {

    //Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    
    var jeopardy = [Jeopardy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        //loadData()
    }

    
    
    //loadData
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do{
                    let questions = try myDecoder.decode(Jeopardy.self, from: data)

//                    for info in questions.results {
//                        jeopardy.append(person)
                    }

                } catch {
                    print(error)
                }
            }
        }
    }


}

