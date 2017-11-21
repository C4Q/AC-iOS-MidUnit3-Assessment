//
//  TPDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Maryann Yin on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class TPDetailViewController: UIViewController, UITextViewDelegate {
    
    var pratchettAuthoredBooks: BookInformation!
    
    @IBOutlet weak var bookImageView: UIImageView!
    
    @IBOutlet weak var bookTitleLabel: UILabel!
    
    @IBOutlet weak var bookSubtitleLabel: UILabel!
    
    @IBOutlet weak var bookPriceLabel: UILabel!
    
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    @IBOutlet weak var isbnThirteenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pictureURL = URL(string: pratchettAuthoredBooks.volumeInfo.imageLinks.thumbnail) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        self.bookImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        bookTitleLabel.text = pratchettAuthoredBooks.volumeInfo.title
        bookSubtitleLabel.text = pratchettAuthoredBooks.volumeInfo.subtitle
        bookPriceLabel.text = pratchettAuthoredBooks.saleInfo.listPrice.amount.description
        bookAuthorLabel.text = pratchettAuthoredBooks.volumeInfo.authors.description
    }

}
