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
    var labelsData: infoData!
    
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblISBN: UILabel!
    @IBOutlet weak var txtViewSummary: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfoData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadLabels()
    }
    

    func loadLabels() {
        imgBook.image = labelsData.image
        lblTitle.text = labelsData.title
        lblSubTitle.text = labelsData.subTitle
        lblPrice.text = labelsData.price
        lblISBN.text = labelsData.codeISBN
        txtViewSummary.text = labelsData.summary
    }
    
    func loadInfoData() {
        let identifierISBN = bookDetail.volumeInfo.industryIdentifiers.filter{$0.type == "ISBN_13"}.first?.identifier ?? bookDetail.volumeInfo.industryIdentifiers.first!.identifier
        let myLogo = getImage()
            labelsData = infoData(image: myLogo ?? #imageLiteral(resourceName: "defaultBook"),
                                  title: bookDetail.volumeInfo.title,
                                  subTitle: bookDetail.volumeInfo.subtitle ?? "Without Subtitle",
                                  price: "Price: \(bookDetail.saleInfo.listPrice.amount)",
                codeISBN: "ISBN_13: \(identifierISBN)",
                summary: bookDetail.volumeInfo.description)
    }
    
    func getImage() -> UIImage? {
        var myLogo = UIImage()
        let apiManager = APIManager()
        apiManager.getData(endpoint: bookDetail.volumeInfo.imageLinks.thumbnail) { (data: Data?) in
            if let myData = data{
                DispatchQueue.main.sync {
                    //self.imgBook.image = UIImage(data: myData)
                    if let logo = UIImage(data: myData) {
                        myLogo = logo
                    }
                }
            }
        }
        return myLogo
    }

}
