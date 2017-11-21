//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    @IBOutlet weak var booksTableView: UITableView!
    
    var books = [Book]()
    override func viewDidLoad() {
        super.viewDidLoad()
        booksTableView.dataSource = self
        getBookData()
    }
    
    
    /// MARK: - Create Function to Load Contacts Data
    func getBookData(){
        //parse data
        guard let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") else {return}
        let myUrl = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: myUrl) else {return}
        let myDecoder = JSONDecoder()
        do{
            //use myDecoder to try and decode the data from the Contacts struct
            let bookInfo = try myDecoder.decode(Books.self, from: data)
            //set that to the contacts instance
            //flatmap the array to get rid of any nils in the data
            self.books = bookInfo.items
        } catch let error {
            print(error)
        }
    }
    
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? BooksDetailViewController{
            destination.books = books[booksTableView.indexPathForSelectedRow!.row]
        }
    }
}

///MARK: - Setting up TableView
extension BooksViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath)
        
        let bookInfo = books[indexPath.row]
        cell.textLabel?.text = bookInfo.volumeInfo.title.capitalized
        cell.detailTextLabel?.text = bookInfo.retailPrice.amount
        
        //adding thumbnail image from the internet
        if let pictureURL = URL(string: bookInfo.imageLinks.smallThumbnail){
            DispatchQueue.global().sync{
                if let data = try? Data.init(contentsOf: pictureURL)  {
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: data)
                        //refreshes the cell: look at documentation
                        cell.setNeedsLayout()
                    }
                }
            }
        }
        return cell
    }
    
}
