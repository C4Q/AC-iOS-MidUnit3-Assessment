//
//  BookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var selectedBook: BookItems?
    @IBOutlet weak var summaryView: UITextView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetails()
    }
    func updateDetails() {
        if let book = selectedBook {
            titleLabel.text = book.volumeInfo.title
            subtitleLabel.text = book.volumeInfo.subtitle ?? ""
            authorLabel.text = "By: \(book.volumeInfo.authors[0])"
            priceLabel.text = "$\(book.saleInfo.retailPrice.amount)"
            summaryView.text = book.volumeInfo.description
            codeLabel.text = "\(book.volumeInfo.industryIdentifiers[0].type): \(book.volumeInfo.industryIdentifiers[0].identifier)"
            if let pictureURL = URL(string: book.volumeInfo.imageLinks.thumbnail) {
                DispatchQueue.global().sync {
                    if let data = try? Data.init(contentsOf: pictureURL) {
                        DispatchQueue.main.async {
                            self.imageLabel.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }
    
}
