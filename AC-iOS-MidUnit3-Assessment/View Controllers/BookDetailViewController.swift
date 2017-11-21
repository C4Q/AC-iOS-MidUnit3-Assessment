//
//  BookDetailViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookDetail: Items!
    
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblISBN: UILabel!
    @IBOutlet weak var txtViewSummary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLabels()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getImage()
    }

    func loadLabels() {
        lblTitle.text = bookDetail.volumeInfo.title
        let subTitle = bookDetail.volumeInfo.subtitle ?? "Without Subtitle"
        lblSubTitle.text = subTitle
        lblPrice.text = "Price: \(bookDetail.saleInfo.listPrice.amount)"
        lblISBN.text = bookDetail.volumeInfo.industryIdentifiers.first!.type
        txtViewSummary.text = bookDetail.volumeInfo.description
    }
    
    func getImage(){
        let apiManager = APIManager()
        apiManager.getData(endpoint: bookDetail.volumeInfo.imageLinks.thumbnail) { (data: Data?) in
            if let myData = data{
                DispatchQueue.main.async {
                    self.imgBook.image = UIImage(data: myData)
                }
            }
        }
    }

}
