//
//  BookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Masai Young on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var book: Item?
    var thumbnail: UIImage?
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ISBNLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = book?.volumeInfo.title
        subtitleLabel.text = book?.volumeInfo.subtitle ?? "No subtitle"
        authorLabel.text = book?.volumeInfo.authors.first
        summaryLabel.text = book?.volumeInfo.description
        priceLabel.text = String((book?.saleInfo.retailPrice.amount)!)
        ISBNLabel.text = book?.volumeInfo.industryIdentifiers.last?.identifier
        bookImageView.image = thumbnail
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
