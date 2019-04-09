//
//  SelectionFilterTableViewController.swift
//  MovieApp
//
//  Created by DeveloperOSA on 4/9/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

class SelectionFilterTableViewController: UITableViewController {
    
    var items : [String] = []
    var key : String = ""
    var selected : String = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Options"
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELLSELECTION")
        if cell == nil { cell = UITableViewCell(style:.value1, reuseIdentifier: "CELLSELECTION") }
        cell?.textLabel?.text = items[indexPath.row]
        if selected == items[indexPath.row] {
            cell?.accessoryType = .checkmark
        }else{
            cell?.accessoryType = .none
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = items[indexPath.row]
        tableView.reloadRows(at: [indexPath], with: .none)
        NotificationCenter.default.post(name:FilterMovieViewController.filterSelectedOptions, object: nil, userInfo: [key:selected])
    }
    
}
