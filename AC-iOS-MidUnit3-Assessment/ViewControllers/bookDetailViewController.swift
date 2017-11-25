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
    var apiManager = MyJSONParser() //used for getImage method
    
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
        self.bookImageView.image = apiManager.getImage(url: selectedBook.volumeInfo.imageLinks.thumbnail)
        bookDescription.text = selectedBook.volumeInfo.description ?? "Description Unavailable"
        for label in bookDetailLabels {
            switch label.tag {
            case 0:
                label.text = "Title: " + selectedBook.volumeInfo.title
            case 1:
                let subtitleText = selectedBook.volumeInfo.subtitle ?? "Unavailable"
                label.text = "Subtitle: " + subtitleText
            case 2:
                label.text = "Author(s): " + selectedBook.volumeInfo.authors.joined(separator: ", ")
            case 3:
                label.text = String(format: "Price:  $%.02f", (selectedBook.saleInfo.listPrice.amount))
            case 4:
                label.text = "ISBN_13:  " + selectedBook.volumeInfo.industryIdentifiers[0].identifier
            default:
                break
            }
        }
        
    }


}
