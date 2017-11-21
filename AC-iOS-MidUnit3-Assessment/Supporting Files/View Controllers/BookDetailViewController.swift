//
//  BookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Reiaz Gafar on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookSubtitleLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookSummaryTextView: UITextView!
    @IBOutlet weak var bookISBNLabel: UILabel!
   
    var book: Book?
    var networkHelper = NetworkHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let book = book else { return }
        
        bookImageView.image = networkHelper.getImage(url: book.volumeInfo.imageLinks.thumbnail)
        bookNameLabel.text = "Name: \(book.volumeInfo.title)"
        bookSubtitleLabel.text = "Subtitle: \(book.volumeInfo.subtitle ?? "No subtitle available.")"
        bookPriceLabel.text = "Price: $\(book.saleInfo.listPrice.amount) USD"
        bookAuthorLabel.text = "Author: \(book.volumeInfo.authors[0])"
        bookISBNLabel.text = "ISBN_13: \(book.volumeInfo.industryIdentifiers[0].identifier)"
        bookSummaryTextView.text = book.volumeInfo.description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension BookDetailViewController {
    /*
     https://stackoverflow.com/questions/28053140/uitextview-is-not-scrolled-to-top-when-loaded
     */
    
    override func viewDidLayoutSubviews() {
        self.bookSummaryTextView.setContentOffset(.zero, animated: false)
    }
}
