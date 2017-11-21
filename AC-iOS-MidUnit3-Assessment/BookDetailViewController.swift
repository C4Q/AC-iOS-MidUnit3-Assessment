//
//  BookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookDetail: ItemsWrapper!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookSubtitleLabel: UILabel!
    @IBOutlet weak var bookAuthorTextLabel: UILabel!
    @IBOutlet weak var bookPriceTextLabel: UILabel!
    @IBOutlet weak var bookTextBox: UITextView!
    @IBOutlet weak var bookImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        bookTitleLabel.text = "Title: \(bookDetail.volumeInfo.title)"
        bookTextBox.text = bookDetail.volumeInfo.description
        bookPriceTextLabel.text = "Price: $\(bookDetail.saleInfo.retailPrice.amount)"
        bookAuthorTextLabel.text = "Author: \(bookDetail.volumeInfo.authors.joined())"
        bookSubtitleLabel.text = "\(bookDetail.searchInfo.textSnippet != nil ? "\(bookDetail.searchInfo.textSnippet)" : "No Subtitles Available")"

        
        if let bookImageURL = URL(string: bookDetail.volumeInfo.imageLinks.thumbnail) {
            DispatchQueue.global().async {
                if let data = try? Data.init(contentsOf: bookImageURL) {
                    DispatchQueue.main.async {
                        self.bookImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
}
