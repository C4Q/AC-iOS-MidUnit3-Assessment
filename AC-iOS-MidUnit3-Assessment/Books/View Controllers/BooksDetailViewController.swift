//
//  BooksDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksDetailViewController: UIViewController {

    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var isbn13Label: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    var book: Book!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        titleLabel.text = book.title
        subtitleLabel.text = book.subtitle
        authorLabel.text = book.authors.joined(separator: ", ")
        priceLabel.text = "$\(book.price) USD"
        isbn13Label.text = book.isbn13
        summaryTextView.text = book.summary
        setupImages()
    }

    func setupImages() {
        //placeholder image
        bookImageView.image = #imageLiteral(resourceName: "defaultBook")
        
        //api image
        let apiManager = APIManager()
        let imageEndpoint = book.imageURL
        DispatchQueue.global().sync {
            apiManager.getData(endpoint: imageEndpoint) { (data: Data?) in
                guard let data = data else {
                    print("Error: Could not get image data.")
                    return
                }
                
                guard let image = UIImage(data: data) else {
                    print("Error: Could not initialize image from data.")
                    return
                }
                
                DispatchQueue.main.async {
                    self.bookImageView.image = image
                }
            }
            
        }
    }
    
}
