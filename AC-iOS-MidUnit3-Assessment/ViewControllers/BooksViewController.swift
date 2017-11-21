//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDataSource {
    var books: [Items] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
       loadData()
    }

    func loadData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let decoder = JSONDecoder()
                do {
                    let allBooksInfo = try decoder.decode(allBooks.self, from: data)
                    self.books = allBooksInfo.items
                }
                catch let error {
                    print(error)
                }
            }
        }
    }

    //MARK - DATA Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let currentBook = books[indexPath.row]
        cell.textLabel?.text = currentBook.volumeInfo.title
        cell.detailTextLabel?.text = currentBook.saleInfo.retailPrice.amount.description
        return cell
    }
    
    // MARK - SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let selectedBook = books[selectedRow]
            destination.book = selectedBook
        }
    }
}


