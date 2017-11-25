//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {
    
    //MARK: - Variables
    var game: JeopardyBrain?
    
    //MARK: - Outlets
    @IBOutlet weak var jeopardyImageView: UIImageView!
    @IBOutlet var jeopardyLabels: [UILabel]!
    @IBOutlet weak var gameMessageLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    //MARK: - Override ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        game = JeopardyBrain.init(jsonFileName: "jeopardyinfo")
        jeopardyImageView.image = UIImage(named: "jeopardyLogo")
        updateGame()
    }
    
    func updateUILabels() {
        textField.text = ""
        continueButton.isHidden = game?.hideUI.rawValue == "true"
        gameMessageLabel.text = game?.gameMessage
        gameMessageLabel.isHidden = game?.hideUI.rawValue == "true"
    }
    
    func updateGame() {
        game?.setupJeopardy()
        view.backgroundColor = UIColor.white
        for label in jeopardyLabels {
            switch label.tag {
            case 0:
                label.text = "Question: \n" + (game?.currentRoundInfo?.question)!
            case 1:
                label.text = "Category: \n" + (game?.currentRoundInfo?.category.title)!
            case 2:
                let value = game?.currentRoundInfo?.value ?? 0
                label.text = "Value: \n" + String(value)
            case 3:
                label.text = "Score: " + (game?.totalAccumalatedScore.description)!
            default:
                break
            }
        }
        textField.isUserInteractionEnabled = true
        updateUILabels()
    }
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        updateGame()
        updateUILabels()
    }
}

extension JeopardyViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        textField.resignFirstResponder()
        textField.isUserInteractionEnabled = false
        view.backgroundColor = (game?.compareAnswerWith(entered: text) == true) ? UIColor.green : UIColor.red
        updateUILabels()
        return true
        
    }
    
}

