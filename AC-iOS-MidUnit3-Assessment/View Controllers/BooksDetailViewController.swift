//
//  BooksDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksDetailViewController: UIViewController {
    
    
    var books: Book?
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var summaryTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    
    func setUpUI(){
        //make sure there is a contact available
        guard let books = books else {return}
        navigationItem.title = books.volumeInfo.title
        nameLabel.text = "Name: \(books.volumeInfo.title)"
        authorLabel.text = " Author: \(books.authors)"
        priceLabel.text = "Price: \(books.retailPrice.amount)"
       summaryTextView.text = "\(books.description)"
        
        
        //setting up image from the internet
        if let pictureURL = URL(string: books.imageLinks.thumbnail){
            DispatchQueue.global().sync{
                if let data = try? Data.init(contentsOf: pictureURL)  {
                    DispatchQueue.main.async {
                        self.bookImageView?.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
