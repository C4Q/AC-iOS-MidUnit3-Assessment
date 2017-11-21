//
//  bookViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Clint Mejia on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookViewController: UIViewController {
    
    //Mark: - Variables
    var books = [Volume]()
    
    //MARK: Outlets
    @IBOutlet weak var bookTableView: UITableView!
    
    //MARK: - Override ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTableView.dataSource = self
        bookTableView.delegate = self
        getBookData()
    }
    
    //MARK: - Functions
    func getBookData() {
        guard let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") else { return }
        let myURL = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: myURL) else { return }
        let myDecoder = JSONDecoder()
        do {
            let books = try myDecoder.decode(BookInfo.self, from: data)
            self.books =  books.items
        }
        catch {
            print(error)
        }
    }
    
    // MARK: - Navigation
}

extension BookViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = books[indexPath.row]
        let cell = self.bookTableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        cell.textLabel?.text = "Title: " + book.volumeInfo.title
        cell.detailTextLabel?.text = String(format: "Price:  $%.02f", (book.saleInfo.listPrice.amount))
        return cell
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? bookDetailViewController {
            destination.selectedBook = books[bookTableView.indexPathForSelectedRow!.row]
        }
    }
}










