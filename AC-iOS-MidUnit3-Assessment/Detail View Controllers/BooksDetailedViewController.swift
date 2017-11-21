//
//  BooksDetailedViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Luis Calle on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksDetailedViewController: UIViewController {
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookSubtitleLabel: UILabel!
    @IBOutlet weak var ISBNLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookPriceLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookSummaryTextView: UITextView!
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let book = book else { return }
        bookTitleLabel.text = book.volumeInfo.title
        if let subtitle = book.volumeInfo.subtitle {
            bookSubtitleLabel.text = subtitle
        } else {
            bookSubtitleLabel.isHidden = true
        }
        //bookImageView.image = UIImage(named: "defaultBook")
        ISBNLabel.text = "ISBN 13: \(getISBN13(isbnArr: book.volumeInfo.industryIdentifiers))"
        bookPriceLabel.text = "Price: $\(book.saleInfo.retailPrice.amount)"
        guard let author = book.volumeInfo.authors.first else { return }
        bookAuthorLabel.text = "Author: \(author)"
        bookSummaryTextView.text = book.volumeInfo.description
        guard let bookImageURL = URL(string: book.volumeInfo.imageLinks.thumbnail) else { return }
        do {
            let data = try Data(contentsOf: bookImageURL)
            bookImageView.image = UIImage(data: data)
        } catch let error {
            print(error)
        }
        
    }
    
    func getISBN13(isbnArr: [ISBNWrapper]) -> String {
        var isbn13 = ""
        for isbn in isbnArr {
            if isbn.type == "ISBN_13" {
                isbn13 = isbn.identifier
            }
        }
        return isbn13
    }

}
