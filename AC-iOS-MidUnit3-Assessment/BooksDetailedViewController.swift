//
//  BooksDetailedViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Richard Crichlow on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksDetailedViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    var selectedBook: BookInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedBook = selectedBook else {
            return
        }
        nameLabel.text = selectedBook.volumeInfo.title
        subtitleLabel.text = selectedBook.volumeInfo.subtitle
        priceLabel.text = "Price: \(selectedBook.saleInfo.retailPrice.amount)"
        authorLabel.text = selectedBook.volumeInfo.allAuthors
        textView.text = selectedBook.volumeInfo.description
        getImageTest()
    }
    func getImageTest() {
        let apiManager = APIManager()
        apiManager.getData(endpoint: (selectedBook?.volumeInfo.imageLinks.thumbnail)!) { (data: Data?) in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}
