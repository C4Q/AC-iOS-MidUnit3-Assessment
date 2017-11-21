//
//  BooksDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if book?.volumeInfo.subtitle != nil{
            bookSubtitleLabel.isHidden = false
            bookSubtitleLabel.text = book?.volumeInfo.subtitle
        }
        bookTitleLabel.text = book?.volumeInfo.title
        bookPriceLabel.text = (book?.saleInfo.retailPrice.amount.description)! + " " + (book?.saleInfo.retailPrice.currencyCode)!
        bookSummary.text = book?.volumeInfo.description
        for authors in (book?.volumeInfo.authors)!{
            bookAuthorLabel.text = authors + " "
        }
        
        for isbnNum in (book?.volumeInfo.industryIdentifiers)!{
            if isbnNum.type == "ISBN_13"{
                isbnLabel.text = isbnNum.type + ": " + isbnNum.identifier
            }
        }
        
        
        
        if let pictureURL = URL(string: (book?.volumeInfo.imageLinks.thumbnail)!) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        self.bookImage.image = UIImage(data: data)
                    }
                }
            }
        }
        
    }
    var book: Books?
    
    
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookSubtitleLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var isbnLabel: UILabel!
    @IBOutlet weak var bookSummary: UITextView!
    
    
}
