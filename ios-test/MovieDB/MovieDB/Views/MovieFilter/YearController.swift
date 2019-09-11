//
//  YearController.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/8/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation
import UIKit

class YearController: UIViewController {

    private var tableView = UITableView()
    private var years = [Int]()
    private var cell_id = "cell_id"
    var yearDelegate: SelectDateDelegate!
    
    override func viewDidLoad() {

        self.title = "Year"

        years += 1950 ... 2019
        years = years.reversed()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cell_id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.frame
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
    }
}

extension YearController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return years.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath)
        let year = years[indexPath.row]
        cell.textLabel?.text = String(year)
        return cell
    }
}

extension YearController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let current = years[indexPath.row]
        yearDelegate.pushYear(year: String(current))
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Protocol Year

protocol SelectDateDelegate {
    func pushYear(year: String)
}
