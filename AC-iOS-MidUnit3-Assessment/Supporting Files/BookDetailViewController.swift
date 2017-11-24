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
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookSubtitle: UILabel!
    @IBOutlet weak var bookPrice: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookSummary: UITextView!
    @IBOutlet weak var bookISBN: UILabel!
    
    
    var selectedBook: ItemWrapper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBookDetails()
        // Do any additional setup after loading the view.
    }
    
    func loadBookDetails() {
        guard let selectedBook = selectedBook else {
            return
        }
        if let imageURL = URL(string: selectedBook.volumeInfo.imageLinks.thumbnail) {
            DispatchQueue.global().async {
                if let imageData = try? Data.init(contentsOf: imageURL) {
                    DispatchQueue.main.async {
                        self.bookImage.image = UIImage(data: imageData)
                    }
                } else {
                    print("nope")
                }
            }
        }
        self.bookName.text = "Title: " + selectedBook.volumeInfo.title
        self.bookSubtitle.text = "Subtitle: " + (selectedBook.volumeInfo.subtitle ?? "")
        self.bookPrice.text = "Price: " + String(selectedBook.saleInfo.retailPrice.amount)
        self.bookAuthor.text = "Author"
        if selectedBook.volumeInfo.authors.count > 1 {
            self.bookAuthor.text! += "s: "
        } else {
            self.bookAuthor.text! += ": "
        }
        self.bookAuthor.text! += selectedBook.volumeInfo.authors.joined(separator: ", ")
        self.bookSummary.text = selectedBook.volumeInfo.description
        if let index = selectedBook.volumeInfo.industryIdentifiers.index(where: {$0.type == "ISBN_13"}) {
            self.bookISBN.text = "ISBN_13: " + selectedBook.volumeInfo.industryIdentifiers[index].identifier
        } else {
            self.bookISBN.text = ""
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
