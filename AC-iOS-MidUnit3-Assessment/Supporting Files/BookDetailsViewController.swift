//
//  BookDetailsViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailsViewController: UIViewController {

    var chosenBook: Book?
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var summaryLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
    }
    
    func populateView() {
        guard let currentBook = chosenBook else { return }
        nameLabel.text = currentBook.volumeInfo.title
        subtitleLabel.text = currentBook.volumeInfo.subtitle ?? "No subtitle available."
        priceLabel.text = "$\(String(currentBook.saleInfo.retailPrice.amount))"
        authorLabel.text = (String(currentBook.volumeInfo.authors[0]))
        summaryLabel.text = currentBook.volumeInfo.description
        bookImage.image = #imageLiteral(resourceName: "defaultBook")
//        if let pictureURL = URL(string: currentBook.volumeInfo.imageLinks.thumbnail) {
//            DispatchQueue.global().sync {
//                if let data = try? Data.init(contentsOf: pictureURL) {
//                    DispatchQueue.main.async {
//                        self.bookImage.image = UIImage(data: data)
//                    }
//                }
//            }
//        }
        
//
//        if let thumbnail = currentBook.volumeInfo.imageLinks.thumbnailImage {
//            bookImage.image = thumbnail
//        } else {
//            currentBook.volumeInfo.imageLinks.getThumbnail() {
//                DispatchQueue.main.async {
//
//                    }
//                    //                    if let image = currentContact.picture.thumbnailImage {
//                    //                        if indexPath == tableView.indexPath(for: cell) {
//                    //                            cell.imageView?.image = image
//                    //                            cell.setNeedsLayout()
//                    //                        }
//                    //                    }
//
//                }
//            }
//        }
////        bookImage.image = currentBook.volumeInfo.imageLinks.thumbnailImage
////    }

}
}
