//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Ashlee Krammer on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var books = [Books]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        loadData()
    }
    
    
    
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            
            let myURL = URL(fileURLWithPath: path)
            
            if let data = try? Data(contentsOf: myURL){
                let myDecoder = JSONDecoder()
                do{
                    let bookModel = try myDecoder.decode(BookModel.self, from: data)
                    for book in bookModel.items {
                        books.append(book)
                    }
                    
                } catch {
                    print(error)
                }
                
            }
            
            
            
            
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aBook = books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath)
        cell.textLabel?.text = aBook.volumeInfo.title
        var author = ""
        for authors in aBook.volumeInfo.authors{
            author = author + authors + " "
        }
        cell.detailTextLabel?.text = author
        return cell
    }
    
    
    
    
    //Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BookDetailViewController {
            let selectedBook = books[(tableView.indexPathForSelectedRow?.row)!]
            destination.books = selectedBook
            
        }
    }
}

