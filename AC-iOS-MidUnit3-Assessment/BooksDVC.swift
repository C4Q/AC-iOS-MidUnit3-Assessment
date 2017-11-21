//  BooksDVC.swift
//  AC-iOS-MidUnit3-Assessment
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class BooksDVC: UIViewController {
	@IBOutlet weak var bookImageView: UIImageView!
	@IBOutlet weak var bookNameLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var authorLabel: UILabel!
	@IBOutlet weak var summaryTextView: UITextView!
	
	var book: Book!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadData()
	}
	
	func loadData() {
		bookNameLabel.text = book.volumeInfo.title
		subtitleLabel.text = book.volumeInfo.subtitle ?? " "
		priceLabel.text = String(book.saleInfo.retailPrice.amount)
		authorLabel.text = book.volumeInfo.authors
		summaryTextView.text = book.volumeInfo.description
		
		
		//load image
		if let url = URL(string: book.volumeInfo.imageLinks.thumbnail) {
			bookImageView.contentMode = .scaleAspectFit
			//doing work on a background thread - to avoid crashing the phone
			DispatchQueue.global().sync {
				if let data = try? Data.init(contentsOf: url) {
					//go back to main thread to update UI
					DispatchQueue.main.async {
						self.bookImageView.image = UIImage(data: data)
					}
				}
			}
		}
	}
}





