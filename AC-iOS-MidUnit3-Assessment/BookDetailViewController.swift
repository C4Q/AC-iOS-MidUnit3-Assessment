//
//  BookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    
    @IBOutlet weak var bookImage: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var summaryTextView: UITextView!
    
    var myBook: Book?
    
    func loadImage() {
        if let imageURL = URL(string: (myBook!.volumeInfo.imageLinks.thumbnail)) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.bookImage.image = UIImage(data: data)
                    }
                }
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        guard let myBook = myBook else {return}
        nameLabel.text = myBook.volumeInfo.title
        authorLabel.text = myBook.volumeInfo.authors[0]
        priceLabel.text = myBook.saleInfo.retailPrice.amount.description + " " + myBook.saleInfo.retailPrice.currencyCode
        summaryTextView.text = myBook.volumeInfo.description
        if let subtitleUnwrapped = myBook.volumeInfo.subtitle {
            subtitleLabel.text = subtitleUnwrapped
        }
        else {
            subtitleLabel.text = "no subtitle"
        }

        // Do any additional setup after loading the view.
    }



}
