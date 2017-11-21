//
//  Terry PratchettViewController.swift
//  AC-iOS-MidUnit3-Assessment
//
//  Created by Maryann Yin on 11/21/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class TerryPratchettViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tpBooksTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tpBooksTable.delegate = self
        tpBooksTable.dataSource = self
    }

}
