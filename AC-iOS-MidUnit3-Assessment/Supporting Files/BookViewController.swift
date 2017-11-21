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
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        let booksInList = bookArray
        let contactsInThisSection = filteredBySearchTermContactsArray.filter { $0.firstLetter == sectionName}
        
        let currentContact = contactsInThisSection[indexPath.row]
        
        cell.textLabel?.text = currentContact.fullName
        cell.imageView?.image =
        cell.detailTextLabel?.text = currentContact.addressString
        
        if let thumbnail = currentContact.picture.thumbnailImage {
            cell.imageView?.image = thumbnail
        } else {
            currentContact.picture.getThumbnail() {
                DispatchQueue.main.async {
                    if tableView.indexPathsForVisibleRows?.contains(indexPath) == true {
                        tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
//                    if let image = currentContact.picture.thumbnailImage {
//                        if indexPath == tableView.indexPath(for: cell) {
//                            cell.imageView?.image = image
//                            cell.setNeedsLayout()
//                        }
//                    }
                    
                }
            }
        }
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
