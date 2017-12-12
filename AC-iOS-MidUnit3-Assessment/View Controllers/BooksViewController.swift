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
    var bookDetails = BookInformation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        booksTableView.dataSource = self
        ///navigationItem.title = bookDetails.hexStringToUIColor(hex: "#ff0000")
        //gits rid of empty cell lines
        booksTableView.tableFooterView = UIView(frame:CGRect.zero)
        // changing colors of the lines
        booksTableView.separatorColor = UIColor.white
        getBookData()
    }
    
            //setting background image of tableview
    override func viewWillAppear(_ animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        
        // Add a background view to the table view
        let backgroundImage = UIImage(named: "bookcaseimg.png")
        let imageView = UIImageView(image: backgroundImage)
        self.booksTableView.backgroundView = imageView
    }

 
    
    /// MARK: - Create Function to Load Contacts Data
    func getBookData(){
        //parse data
        guard let path = Bundle.main.path(forResource: "bookinfo", ofType: "json") else {return}
        let myUrl = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: myUrl) else {return}
        let myDecoder = JSONDecoder()
        do{
            let bookInfo = try myDecoder.decode(Books.self, from: data)
            self.books = bookInfo.items
        } catch let error {
            print(error)
        }
        for book in books{
           print(book.volumeInfo.industryIdentifiers)
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
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = bookDetails.hexStringToUIColor(hex: "#00ffff")
        cell.detailTextLabel?.text = "\(bookInfo.saleInfo.retailPrice.amount)"
        cell.backgroundColor = UIColor.clear
        
        //transaparent
         //cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
        
      
        //adding thumbnail image from the internet
        if let pictureURL = URL(string: bookInfo.volumeInfo.imageLinks.smallThumbnail){
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

//https://stackoverflow.com/questions/24397189/changing-the-height-of-uitabbar-in-ios7-8
extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = 55// adjust your size here
        return sizeThatFits
    }
    
    //changing font size
    //changing selected/unselected tabbar item color
    //https://stackoverflow.com/questions/18734794/how-can-i-change-the-text-and-icon-colors-for-tabbaritems-in-ios-7/19665559#19665559
}

/*
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}
*/
//https://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
//changing hex to UIColor

///If you wanted it always to return a value, change init? to be init then change the return nil line at the end to be return UIColor.black or whatever you'd like the default value to be.

///To use the extension, write code like this: let gold = UIColor(hexString: "#ffe700ff")
