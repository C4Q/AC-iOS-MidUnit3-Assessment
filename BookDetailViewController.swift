//
//  BookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Lisa J on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var bookDetail: Book!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    func setupUI() {
        titleLabel.text = bookDetail.volumeInfo.title
        subtitleLabel.text = bookDetail.volumeInfo.subtitle
        //print(bookDetail.subtitle)
        priceLabel.text = "\(bookDetail.saleInfo.listPrice.amount)"
        authorLabel.text = "\(bookDetail.volumeInfo.authors)"
        textView.text = bookDetail.volumeInfo.description
//        if let url = URL(string: bookDetail.volumeInfo.imageLinks.thumbnail) {
//            DispatchQueue.global().sync {
//                //loading async
//                if let data = try? Data.init(contentsOf: url) {
//                    //updates UI on main thread
//                    DispatchQueue.main.async {
//                        self.imageView.image = UIImage(data: data)
//                    }
//                }
//            }
//        }
    }
}
