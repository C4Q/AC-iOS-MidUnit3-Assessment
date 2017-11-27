//
//  BookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Ashlee Krammer on 11/27/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    
    var books: Books!
    var stuff: String = ""
    var secondTitle: String = ""
    var ISBN: String = ""
//Outlets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDVC()
        textView.text = stuff
        image.image = #imageLiteral(resourceName: "defaultBook")
    }

    func loadDVC() {
        
        if books.volumeInfo.subtitle == nil {
            secondTitle = ""
        } else {
            secondTitle = ", Subtitle: " + books.volumeInfo.subtitle!
        }
        
        stuff =
        """
        Title: \(books.volumeInfo.title) \(secondTitle)
        
        Author(s): \(books.volumeInfo.authors)
        
        Price: \(books.saleInfo.retailPrice.currencyCode) \(books.saleInfo.retailPrice.amount)
        
        ISBN_13: \(books.volumeInfo.industryIdentifiers)
        
        Description: \(books.volumeInfo.description)
        
        """
        
        
        
        
        
        
    }
    
    
    
    
}
