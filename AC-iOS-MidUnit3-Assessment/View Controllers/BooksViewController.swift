//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    var books = [Books]()
    
    func loadData(){
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json"){
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL){
                let myDecoder = JSONDecoder()
                do {
                    let bookModel = try myDecoder.decode(BookModel.self, from: data)
                    
                    for elements in bookModel.items{
                        books.append(elements)
                    }
                }catch{
                    print(error)
                }
            }
        }
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath)
        let bookToSet = books[indexPath.row]
        cell.textLabel?.text = bookToSet.volumeInfo.title
        cell.detailTextLabel?.text = bookToSet.saleInfo.retailPrice.amount.description + " " + bookToSet.saleInfo.retailPrice.currencyCode
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BooksDetailViewController{
            let selectedRow = tableView.indexPathForSelectedRow?.row
            let selectedBook = books[selectedRow!]
            destination.book = selectedBook
            
        }
    }

}
