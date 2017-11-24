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

    
    
//       func loadData() {
//        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
//            let myURL = URL(fileURLWithPath: path)
//            if let data = try? Data(contentsOf: myURL) {
//                let myDecoder = JSONDecoder()
//                do{
//                    //let theseBooks = try myDecoder.decode(Books.self, from: data)
//
//                 // books.append(theseBooks)
//                   print("editing")
//                } catch {
//                    print(error)
//                }
//            }
//        }
//    }
    
    
    
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "jeopardyinfo", ofType: "json") {
            
            let myURL = URL(fileURLWithPath: path)
            
            if let data = try? Data(contentsOf: myURL){
                
//                books = Books.getBooks(from: data)
                
                books = Books.getBooks(from: data)  
 
                    
                }
                
                
                
                
            }
            
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let aBook = books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath)
        cell.textLabel?.text = aBook.title
        cell.detailTextLabel?.text = aBook.authors.description
        return cell
    }
    
    
}
