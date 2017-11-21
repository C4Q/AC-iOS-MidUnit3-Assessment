//
//  BookViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UITableViewDataSource {
    

    
    @IBOutlet weak var bookTableView: UITableView!
    
    var booksArray = [Items]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookTableView.dataSource = self
        loadBookData()
    }
    
    func loadBookData() {
        guard let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") else {
            return
        }
        let myURL = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: myURL) else { return }
        do {
            let books = try JSONDecoder().decode(Book.self, from: data)
            self.booksArray = books.items
        }
        catch let error {
            print(error)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = booksArray[indexPath.row]
        let cell = self.bookTableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        cell.textLabel?.text = book.volumeInfo.title
        cell.detailTextLabel?.text = "$\(String(describing: book.saleInfo.listPrice.amount))"
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailViewController {
            let selectedRow = self.bookTableView.indexPathForSelectedRow!.row
            let selectedBook = self.booksArray[selectedRow]
            destination.book = selectedBook
        }
    }
    
    
    
    
    


}
