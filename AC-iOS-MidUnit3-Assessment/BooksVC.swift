//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.

import UIKit

class BooksVC: UIViewController {
	
	//MARK: - Outlets
	@IBOutlet weak var bookTableView: UITableView!
	
	//MARK: - Overrides
	override func viewDidLoad() {
		super.viewDidLoad()
		self.bookTableView.dataSource = self
		//		bookTableView.delegate = self
		loadBookData()
	}
	
	//MARK: - Variables/Constants
	var books = [Book]()
	
	//MARK: - Functions
	func loadBookData() {
		if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
			let url = URL(fileURLWithPath: path)
			if let data = try? Data(contentsOf: url) {
				do {
					let books = try JSONDecoder().decode(Items.self, from: data)
					self.books = books.items //maybe change
					DispatchQueue.main.async {
						self.bookTableView.reloadData()
					}
				}
				catch {
					print(error)
				}
			}
		}
	}
}

//MARK: - booksTableView - DataSource Methods
extension BooksVC: UITableViewDataSource {
	func numberOfSections(in bookTableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ bookTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return books.count
	}
	
	func tableView(_ bookTableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = bookTableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
		let currentbook = books[indexPath.row]
		cell.textLabel?.text = currentbook.volumeInfo.title
		cell.detailTextLabel?.text = String(currentbook.saleInfo.retailPrice.amount)
		return cell
	}
}

//MARK: - Navigation - Segue
extension BooksVC {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? BooksDVC {
			let row = bookTableView.indexPathForSelectedRow!.row
			let book = self.books[row]
			destination.book = book
		}
	}
	
}

