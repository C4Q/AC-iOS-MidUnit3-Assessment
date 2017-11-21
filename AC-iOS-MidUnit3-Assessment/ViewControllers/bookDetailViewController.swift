//
//  bookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Clint Mejia on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class bookDetailViewController: UIViewController {
    
    //MARK: - Variables
    var selectedBook: Volume? = nil
    
    //MARK: - Oulets
    @IBOutlet var bookDetailLabels: [UILabel]!
    @IBOutlet weak var bookDescription: UITextView!
    @IBOutlet weak var bookImageView: UIImageView!
    
    //MARK: - Overrides ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
    }
    
    //MARK: - functions
    func setupInitialView() {
        guard let selectedBook = selectedBook else { return }
        bookDescription.text = selectedBook.volumeInfo.description ?? "Description Unavailable"
        bookImageView.image = UIImage(named: "defaultBook")
        for label in bookDetailLabels {
            switch label.tag {
            case 0:
                label.text = "Title: " + selectedBook.volumeInfo.title
            case 1:
                let subtitleText = selectedBook.volumeInfo.subtitle ?? "Unavailable"
                label.text = "Subtitle: " + subtitleText
            case 2:
                label.text = "Authors: " + selectedBook.volumeInfo.authors[0]
            case 3:
                label.text = String(format: "Price:  $%.02f", (selectedBook.saleInfo.listPrice.amount))
            default:
                break
            }
        }
        
    }


}
