//
//  MovieDetailsTableViewController.swift
//  
//
//  Created by Matías Contreras Selman on 11/19/18.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {

    var movie : Movie? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

   
}
