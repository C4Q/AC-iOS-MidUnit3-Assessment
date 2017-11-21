//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {
    
    var jeopardyGameInfo: [JeopardyMaterial] = []
    
    @IBOutlet weak var jeopardyLogo: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBAction func responseTextField(_ sender: UITextField) {
    }
    
    @IBAction func nextQuestionButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                do {
                self.jeopardyGameInfo = try JSONDecoder().decode([JeopardyMaterial].self, from: data)
                }
                catch {
                    print("Error Decoding Data")
                }
            }
        }
    }
    
    
}

