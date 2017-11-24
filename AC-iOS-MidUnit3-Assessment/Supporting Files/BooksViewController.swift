//
//  BooksViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by C4Q on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class BooksViewController: UIViewController {
    
    var books = [ItemWrapper]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let url = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: url) {
                do {
                    let json = try JSONDecoder().decode(BookJSONTop.self, from: data)
                    self.books = json.items
                } catch {
                    print("///////////////////////")
                    print(error)
                    print("///////////////////////")
                }
            }
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension BooksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Book Cell", for: indexPath)
        let bookToUse = books[indexPath.row]
        
        cell.textLabel?.text = bookToUse.volumeInfo.title
        cell.detailTextLabel?.text = bookToUse.volumeInfo.subtitle ?? ""
        if let imageURL = URL(string: bookToUse.volumeInfo.imageLinks.thumbnail) {
            DispatchQueue.global().async {
                if let imageData = try? Data.init(contentsOf: imageURL) {
                    print(imageData)
                    DispatchQueue.main.async {
                        cell.imageView?.image = UIImage(data: imageData)
                    }
                } else {
                    print("nope")
                }
            }
        }
        return cell
    }
}

extension BooksViewController: UITableViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Book Detail" else {
            return
        }
        guard let bookDetailViewController = segue.destination as? BookDetailViewController else {
            return
        }
        guard let selectedCell = sender as? UITableViewCell else {
            return
        }
        guard let bookIndex = tableView.indexPath(for: selectedCell)?.row else {
            return
        }
        bookDetailViewController.selectedBook = books[bookIndex]
    }
}
