//
//  BookDetailedViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailedViewController: UIViewController {
    var specificBook: BookInfo? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let specificBook = specificBook else { return }
        // Do any additional setup after loading the view.
        setUpLabels()
        summaryTextView.text = specificBook.volumeInfo.description
        
    }
    
    
    @IBOutlet var Labels: [UILabel]!
    @IBOutlet weak var summaryTextView: UITextView!
    
    
    func setUpLabels() {
        for label in Labels {
            switch label.tag {
            case 0:
                label.text = specificBook?.volumeInfo.title
            case 1:
                label.text = specificBook?.volumeInfo.subtitle ?? ""
            case 2:
                label.text = specificBook?.volumeInfo.authors[0]
            case 3:
                guard let price = specificBook?.saleInfo.retailPrice.amount else { return }
                label.text = String(describing: price)
            default:
                "Not available"
            }
        }
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
