//
//  BookViewController+Extension.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit
extension BookViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - TableView Datasource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = books[indexPath.row]
        let bookCell = bookTableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath)
        bookCell.textLabel?.text = book.volumeInfo.title
        bookCell.detailTextLabel?.text = "Price: \(book.saleInfo.listPrice.amount)"
        getImage(bookCell, indexPath.row)
        //self.bookTableView.reloadData()
        return bookCell
    }
    
    func getImage(_ cell: UITableViewCell,_ index: Int) {
        let apiManager = APIManager()
        apiManager.getData(endpoint: books[index].volumeInfo.imageLinks.smallThumbnail) { (data: Data?) in
            if let myData = data{
                DispatchQueue.main.async {
                    cell.imageView?.image = UIImage(data: myData)!
                    self.bookTableView.reloadData()
                }
            }
        }
    }
}
