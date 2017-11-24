//
//  BookViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    var books = [Items]()
    
    
    @IBOutlet weak var bookTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookTableView.delegate = self
        self.bookTableView.dataSource = self
        loadBooksData()
    }

    func loadBooksData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let booksDecoded = try myDecoder.decode(Book.self, from: data)
                    self.books = booksDecoded.items
                } catch let error {
                    print("Unexpeted error:", error)
                    return
                }
            }
        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let bookDetail = books[bookTableView.indexPathForSelectedRow!.row]
        let bookDVC = segue.destination as? BookDetailViewController
        bookDVC?.bookDetail = bookDetail
    }
}


