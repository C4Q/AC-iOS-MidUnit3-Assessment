//
//  BookDetailsViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    var book: Book?
    var ISBNindex: Int = 0
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var ISBNLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let book = book else {return}
        self.nameLabel.text = "Title: \(book.volumeInfo.title)"
        if let subtitle = book.volumeInfo.subtitle {
            self.subtitleLabel.text = "Subtitle: \(subtitle)"
        } else {
            self.subtitleLabel.isHidden = true
            
        }
        
     let amount = book.saleInfo.retailPrice.amount
         let currency = book.saleInfo.retailPrice.currencyCode ?? "USD"
        if amount != nil {
            self.priceLabel.text = "Retail price: " + book.saleInfo.retailPrice.amount!.description + " " + currency
        }
        let authors = book.volumeInfo.authors.joined(separator: " ")
        self.authorLabel.text = "Author: \(authors)"
        
        for (index, item) in book.volumeInfo.industryIdentifiers.enumerated() {
            if item.type == "ISBN_13" {
                self.ISBNindex = index
            }
        }
        self.ISBNLabel.text = "ISBN: " + book.volumeInfo.industryIdentifiers[ISBNindex].identifier
        self.textView.text = book.volumeInfo.description
        
        if let imageUrl = URL(string: book.volumeInfo.imageLinks.thumbnail) {
            DispatchQueue.global().async {
        if let iamgeData = try? Data(contentsOf: imageUrl) {
            DispatchQueue.main.async {
            self.imageView.image = UIImage(data: iamgeData)
            }
        }
        }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
