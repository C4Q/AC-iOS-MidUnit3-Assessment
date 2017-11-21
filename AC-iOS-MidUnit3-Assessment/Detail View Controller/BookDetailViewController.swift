//
//  BookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var summaryView: UITextView!    
    
    var book: Items? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let book = book else {
            return
        }
        titleLabel.text = book.volumeInfo.title
        subtitleLabel?.text = book.volumeInfo.subtitle
        authorLabel.text = String(describing: book.volumeInfo.authors[0])
        priceLabel.text = "$\(String(describing: book.saleInfo.listPrice.amount))"
        summaryView.text = book.volumeInfo.description
    }



}
