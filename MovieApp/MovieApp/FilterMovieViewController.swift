//
//  FilterMovieViewController.swift
//  MovieApp
//
//  Created by DeveloperOSA on 4/8/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

class FilterMovieViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var items : [String : [String]] = ["Date" : [],"Genres" : []]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        tableView.reloadData()
    }
}

extension FilterMovieViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: .default, reuseIdentifier: "CELL")
    }
}


extension FilterMovieViewController : UITableViewDelegate {
    
}
