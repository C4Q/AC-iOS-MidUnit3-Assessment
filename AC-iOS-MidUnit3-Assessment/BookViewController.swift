//
//  BookViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   var model = BookAPIManager()
    var books = [Book]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.books = model.getBooks()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "book cell", for: indexPath)
        cell.textLabel?.text = books[indexPath.row].volumeInfo.title
        let subtitle = books[indexPath.row].saleInfo.retailPrice.amount?.description
        let currency = books[indexPath.row].saleInfo.retailPrice.currencyCode ?? "USD"
        if subtitle != nil {
        cell.detailTextLabel?.text = "\(subtitle!) \(currency)"
        }
        return cell
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailsViewController {
           let selectedIndex = tableView.indexPathForSelectedRow!.row
            let selectedBook = books[selectedIndex]
            destination.book = selectedBook
        }
    }
    

   

}
