//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var bookTableView: UITableView!
    
    
    var books = [Book]()
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let books = try myDecoder.decode(itemsWrapper.self, from: data)
                    self.books = books.items
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myBook = books[indexPath.row]
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath)
        cell.textLabel?.text = myBook.volumeInfo.title
        cell.detailTextLabel?.text = myBook.saleInfo.retailPrice.amount.description + " " + myBook.saleInfo.retailPrice.currencyCode
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationBookDVC = segue.destination as? BookDetailViewController {
            let selectedRow = bookTableView.indexPathForSelectedRow?.row
            let selectedBook = books[selectedRow!]
            destinationBookDVC.myBook = selectedBook
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.bookTableView.dataSource = self
        self.bookTableView.delegate = self

        // Do any additional setup after loading the view.
    }


}
