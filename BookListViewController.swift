//
//  BookListViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Lisa J on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var books = [Book]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    //outer wrapper
                    let itemWrapper = try myDecoder.decode(ItemWrapper.self, from: data)
                    print("works")
                    //inner wrapper
                    self.books = itemWrapper.items
                
                    
                    
                }catch let error{
                    print(error)
                }
            }
        }
        for book in books {
            print(book.volumeInfo.title)
        }

    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //print(books.count)
            return books.count
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let book = books[indexPath.row]
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "Book cell", for: indexPath)
            cell.textLabel?.text = book.volumeInfo.title
            cell.detailTextLabel?.text = "\(book.saleInfo.listPrice.amount)"
            
            return cell
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookdetailsegue" {
            if let destination = segue.destination as? BookDetailViewController {
                let row = tableView.indexPathForSelectedRow!.row
                destination.bookDetail = self.books[row]
            }
        }
        return
    }
    
}
