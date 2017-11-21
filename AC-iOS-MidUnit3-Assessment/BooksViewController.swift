//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Richard Crichlow on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var allBooks = [BookInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
loadData()
        
    }
    func loadData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                let myDecoder = JSONDecoder()
                do {
                    let allBooks = try myDecoder.decode(BooksTopLevel.self, from: data)
                    self.allBooks = allBooks.items
                }
                catch let error {
                    print(error)
                }
            }
            self.allBooks = self.allBooks.sorted{$0.volumeInfo.title < $1.volumeInfo.title}
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBooks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let aBook = allBooks[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath)
        
        cell.textLabel?.text = aBook.volumeInfo.title
    
        cell.detailTextLabel?.text = " Price: \(aBook.saleInfo.retailPrice.amount)"
        
        if let pictureURL = URL(string: aBook.volumeInfo.imageLinks.smallThumbnail) {
            DispatchQueue.global().sync {
                if let data = try? Data.init(contentsOf: pictureURL) {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        cell.setNeedsLayout()
                    }
                }
            }
        }//Doesn't Load Image. Not exactly sure why.
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? BooksDetailedViewController {
            let selectedRow = self.tableView.indexPathForSelectedRow!.row
            let selectedBook = self.allBooks[selectedRow]
            destination.selectedBook = selectedBook
        }
    }
}
