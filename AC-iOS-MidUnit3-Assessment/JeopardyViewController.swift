//
//  JeopardyViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Richard Crichlow on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class JeopardyViewController: UIViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var messageToUser: UILabel!
    
    @IBAction func nextQuestionButton(_ sender: UIButton) {
        
    }
    
    @IBOutlet weak var texfield: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
