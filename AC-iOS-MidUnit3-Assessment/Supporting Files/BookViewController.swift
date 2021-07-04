//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var bookArray = [Book]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        loadData()
        
    }

    func loadData() {
        let jsonBooks = ParsedJSON.getBook()
        for book in jsonBooks {
            bookArray.append(book)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        let booksInList = bookArray[indexPath.row]
        
        cell.textLabel?.text = "\(booksInList.volumeInfo.title)"
        cell.detailTextLabel?.text = "$\(String(booksInList.saleInfo.retailPrice.amount))"
        
//        if let thumbnail = booksInList.volumeInfo.imageLinks.thumbnailImage {
//            cell.imageView?.image = thumbnail
//        } else {
//            booksInList.volumeInfo.imageLinks.getThumbnail() {
//                DispatchQueue.main.async {
//                    if tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
//                        tableView.reloadRows(at: [indexPath], with: .automatic)
//                    }
////                    if let image = currentContact.picture.thumbnailImage {
////                        if indexPath == tableView.indexPath(for: cell) {
////                            cell.imageView?.image = image
////                            cell.setNeedsLayout()
////                        }
////                    }
//
//                }
//            }
//        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell,
            let detailVC = segue.destination as? BookDetailsViewController,
            let indexPath = tableView.indexPath(for: cell)
            else { return }
        
        let chosenRow = tableView.indexPathForSelectedRow!.row
        let chosenBook = bookArray[chosenRow]

        detailVC.chosenBook = chosenBook
        
    }
 
    
    
    
    
    
}
