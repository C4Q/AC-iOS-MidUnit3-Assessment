//
//  BookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var book: Items?
    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var summary: UITextView!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetail()
        // Do any additional setup after loading the view.
    }

    func updateDetail() {
        guard let book = book else {
            return
        }
//        if let pictureURL = URL(string: book.volumeInfo.imageLinks!.smallThumbnail!) {
//            DispatchQueue.global().sync {
//                if let data = try? Data.init(contentsOf: pictureURL) {
//                    DispatchQueue.main.sync {
//                        self.bookImage.image = UIImage(data: data)
//                    }
//                }
//            }
//        }
        price.text = book.saleInfo.retailPrice.amount.description
        bookImage.image = #imageLiteral(resourceName: "defaultBook")
        bookTitle.text = book.volumeInfo.title
        summary.text = book.volumeInfo.description
        author.text = book.volumeInfo.authors.first! //fix this
        subtitle.text = book.volumeInfo.subtitle
        
    }

}

//nameLabel.text = selectedContact.name.first + " " + selectedContact.name.last
//email.text = selectedContact.email
//location.text = selectedContact.location.city
//
//}

