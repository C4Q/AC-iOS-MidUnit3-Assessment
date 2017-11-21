//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    var books = [ItemsWrapper]()

    @IBOutlet weak var booksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booksTableView.dataSource = self
        booksTableView.delegate = self
        loadData()
    }
}

extension BooksViewController: UITableViewDataSource, UITableViewDelegate {
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let allTheBooks = try myDecoder.decode(Books.self, from: data)
                    self.books = allTheBooks.items
                }
                catch {
                    print("///////////////////////////")
                    print(error)
                    print("///////////////////////////")
                }
            }
        }
        for book in books {
            print(book)
        }
    }
    
    
    //MARK: - REQUIRED TABLEVIEW METHODS
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mybooks = books[indexPath.row]
        let cell = booksTableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        cell.textLabel?.text = mybooks.volumeInfo.title
        cell.detailTextLabel?.text = "Price: $\(mybooks.saleInfo.retailPrice.amount)"
        
        //GET SMALL THUMBNAIL
        if let bookImageURL = URL(string: mybooks.volumeInfo.imageLinks.smallThumbnail) {
            DispatchQueue.global().async {
                if let data = try? Data.init(contentsOf: bookImageURL) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                    }
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    //PREPARE SEGUE

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BookDetailSegue" {
            if let destination = segue.destination as? BookDetailViewController {
                let row = booksTableView.indexPathForSelectedRow!.row
                destination.bookDetail = self.books[row]
            }
        }
    }
}
