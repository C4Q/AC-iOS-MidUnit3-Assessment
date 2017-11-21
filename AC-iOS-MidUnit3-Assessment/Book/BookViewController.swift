//
//  ViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q  on 11/20/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BookViewController: UIViewController {

    @IBOutlet weak var bookTableView: UITableView!
    
    
    private var books: BookAPIResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.bookTableView.dataSource = self
        books = BookAPIResponse.fetchUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 1. We need to check what our sender is. Afterall, there might be multiple segues set up...
        // 2. check for the right storyboard segue
        // 3. Get the destination VC
        
        guard let destination = segue.destination as? BookDetailViewController else {
            return
        }
        
        if let activatedCell = sender as? UITableViewCell, segue.identifier == "BookSegue" {
            // 4. Getting the movie at the tapped cell
            let cellIndex = bookTableView.indexPath(for: activatedCell)!
            destination.book = books?.items[cellIndex.row]
            destination.thumbnail = activatedCell.imageView?.image
        }
    }


}

// MARK: Table View Data Source
extension BookViewController: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (books?.items.count)!
    }
    
    // MARK: - Cell Rendering
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bookTableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath)
        let currentBook = books?.items[indexPath.row]
        cell.textLabel?.text = currentBook?.volumeInfo.title
        cell.detailTextLabel?.text = String((currentBook?.saleInfo.retailPrice.amount)!)
        
        if let albumURL = URL(string: (currentBook?.volumeInfo.imageLinks.thumbnail)!) {
            
            // doing work on a background thread
            DispatchQueue.global().async {
                if let data = try? Data.init(contentsOf: albumURL) {
                    
                    // go back to main thread to update UI
                    DispatchQueue.main.sync {
                        cell.imageView?.image = UIImage(data: data)
                        
                    }
                }
            }
        }
        
        return cell
    }
    
}

