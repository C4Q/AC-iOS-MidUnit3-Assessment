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
    var author: String = ""
//Outlets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDVC()
        textView.text = stuff
    
        
        
        
        
        
        if let pictureURL = URL(string: (books?.volumeInfo.imageLinks.thumbnail)!) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        self.image.image = UIImage(data: data)
                    }
                }
            }
        
        

        
        
        
        
        }
        
    }

    func loadDVC() {
        
        
        
        for identifier in books.volumeInfo.industryIdentifiers {
            
            if identifier.type == "ISBN_13" {
                
                ISBN = identifier.identifier
            }
        
        }
        
        
        
        for writer in books.volumeInfo.authors {
            author = author + writer
        }
        
        
        
        if books.volumeInfo.subtitle == nil {
            secondTitle = ""
        } else {
            secondTitle = ", Subtitle: " + books.volumeInfo.subtitle!
        }
        
        stuff =
        """
        Title: \(books.volumeInfo.title) \(secondTitle)
        
        Author(s): \(author)
        
        Price: \(books.saleInfo.retailPrice.currencyCode) \(books.saleInfo.retailPrice.amount)
        
        ISBN_13: \(ISBN)
        
        Description: \(books.volumeInfo.description)
        
        """
        
        
        
        
        
        
    }
    
    
    
    
}
