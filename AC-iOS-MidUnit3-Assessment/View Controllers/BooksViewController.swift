//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Luis Calle on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var booksTableView: UITableView!
    
    var allBooks = [Book]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.booksTableView.delegate = self
        self.booksTableView.dataSource = self
        loadBooksData()
    }
    
    func loadBooksData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let theURL = URL(fileURLWithPath: path)
            do {
                let data = try Data(contentsOf: theURL)
                let myDecoder = JSONDecoder()
                let booksList = try myDecoder.decode(AllBooks.self, from: data)
                self.allBooks = booksList.items
            }
            catch let error {
                print(error)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BooksDetailedViewController {
            guard let selectedPath = booksTableView.indexPathForSelectedRow else {
                return
            }
            let selectedRow = selectedPath.row
            let selectedBook = self.allBooks[selectedRow]
            destination.book = selectedBook
        }
    }

}

extension BooksViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.allBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bookCell = tableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath)
        let selectedBook = self.allBooks[indexPath.row]
        bookCell.textLabel?.text = selectedBook.volumeInfo.title
        bookCell.detailTextLabel?.text = selectedBook.saleInfo.retailPrice.amount.description
        return bookCell
    }
    
}
