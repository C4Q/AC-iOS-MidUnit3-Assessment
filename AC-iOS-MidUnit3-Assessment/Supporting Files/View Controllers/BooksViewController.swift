//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Reiaz Gafar on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        books = BookCollection.getBookData().items!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? BookDetailViewController else { return }
        let selectedRow = tableView.indexPathForSelectedRow?.row
        let selectedBook = books[selectedRow!]
        destination.book = selectedBook
    }

}

    // MARK: - TableView

extension BooksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        let selectedRow = indexPath.row
        let selectedBook = books[selectedRow]
        cell.textLabel?.text = selectedBook.volumeInfo.title
        cell.detailTextLabel?.text = selectedBook.volumeInfo.subtitle ?? "No subtitle available."
        return cell
    }
    
}
