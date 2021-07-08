//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var bookTableView: UITableView!
    var bookList = [BookInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        bookTableView.delegate = self
        bookTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let bookDecoder = JSONDecoder()
                do {
                    let books = try bookDecoder.decode(Books.self, from: data)
                    self.bookList = books.items
                }
                catch let error {
                    print(error)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(bookList)
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = bookList[indexPath.row]
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        cell.textLabel?.text =  book.volumeInfo.title
        guard let subtitle = book.volumeInfo.subtitle else {return cell}
        cell.detailTextLabel?.text = subtitle
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailedViewController {
            destination.specificBook = bookList[bookTableView.indexPathForSelectedRow!.row]
        }
        
    }
    
}
