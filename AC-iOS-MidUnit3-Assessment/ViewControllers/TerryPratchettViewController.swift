//
//  Terry PratchettViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Maryann Yin on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class TerryPratchettViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pratchettWorks: [BookInformation] = []

    @IBOutlet weak var tpBooksTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        tpBooksTable.delegate = self
        tpBooksTable.dataSource = self
    }
    
    func loadData() {
        if let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") {
            let myURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: myURL) {
                do {
                    let responseDict = try JSONDecoder().decode(PratchettBooks.self, from: data)
                    self.pratchettWorks = responseDict.items
                    print(responseDict)
                }
                catch {
                    print("Error Decoding Data")
                    print(error)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pratchettWorks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pratchettTitles = self.pratchettWorks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TPBook", for: indexPath)
        cell.textLabel?.text = pratchettTitles.volumeInfo.title
        cell.detailTextLabel?.text = pratchettTitles.volumeInfo.subtitle
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? TPDetailViewController {
            let selectedBook = pratchettWorks[tpBooksTable.indexPathForSelectedRow!.row]
            destination.pratchettAuthoredBooks = selectedBook
        }
    }
    
}
