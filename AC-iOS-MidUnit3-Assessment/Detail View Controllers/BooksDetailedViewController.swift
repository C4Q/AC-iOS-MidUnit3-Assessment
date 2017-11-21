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
        bookImageView.image = UIImage(named: "defaultBook")
        bookPriceLabel.text = "$\(book.saleInfo.retailPrice.amount)"
        bookAuthorLabel.text = book.volumeInfo.authors.first
        bookSummaryTextView.text = book.volumeInfo.description
//        guard let bookImageURL = URL(string: book.volumeInfo.imageLinks.thumbnail) else { return }
//        do {
//            let data = try Data(contentsOf: bookImageURL)
//            bookImageView.image = UIImage(data: data)
//        } catch let error {
//            print(error)
//        }
        
    }

}
