//
//  BookViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    var bookArray = [BookItems]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tableView.dataSource = self
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let allBookInfo = try myDecoder.decode(Book.self, from: data)
                    self.bookArray = allBookInfo.items
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bookDetail = segue.destination as? BookDetailViewController {
            let selectedRow = tableView.indexPathForSelectedRow!.row
            let selectedBook = bookArray[selectedRow]
            bookDetail.selectedBook = selectedBook
        }
    }
}
extension BookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let thisBook = bookArray[indexPath.row]
        cell.textLabel?.text = thisBook.volumeInfo.title
        cell.detailTextLabel?.text = "$\(thisBook.saleInfo.retailPrice.amount)"
        return cell
    }
}






