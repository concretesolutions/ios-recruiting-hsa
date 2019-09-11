//
//  MovieFilterController.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/7/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation
import UIKit

class MovieFilterController: UIViewController {
    var filterDelegate: FilterSelectionDelegate!
    var tableView = UITableView()
    var rows = [FilterRows]()
    let cell_filter_id = "cell_filter_id"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
        view.backgroundColor = .white
        setupTableView()
    }

    let applyFilterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(red: 0.967, green: 0.806, blue: 0.357, alpha: 1.0)
        btn.setTitle("Apply Filter", for: .normal)
        btn.tintColor = .black
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(applyFilterAction), for: .touchUpInside)
        return btn
    }()

    @objc func applyFilterAction() {
        filterDelegate.searchWithFilter(year: rows[0].value,
                                        genre: rows[1].value)
        navigationController?.popViewController(animated: true)
    }
}

extension MovieFilterController: UITableViewDataSource {
    func setupTableView() {
        // Define tableview cells on table
        tableView.register(FilterCell.self, forCellReuseIdentifier: cell_filter_id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        tableView.frame = view.frame

        view.addSubview(applyFilterButton)
        view.superview?.bringSubviewToFront(applyFilterButton)

        let applyFilterButtonConstrains = [
            applyFilterButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            applyFilterButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            applyFilterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            applyFilterButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        NSLayoutConstraint.activate(applyFilterButtonConstrains)

        let array = [FilterRows(title: "Date", value: "2019"),
                     FilterRows(title: "Genres", value: "Terror")]
        rows = array
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_filter_id, for: indexPath) as! FilterCell
        cell.model = row
        return cell
    }
}

extension MovieFilterController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // Year Selection
            let yearController = YearController()
            yearController.yearDelegate = self
            navigationController?.pushViewController(yearController, animated: true)

        } else {
            // Genre Selection
            let genreController = GenreController()
            genreController.genreDelegate = self
            navigationController?.pushViewController(genreController, animated: true)
        }
    }
}

// MARK: Protocol Filter

protocol FilterSelectionDelegate {
    func searchWithFilter(year: String, genre: String)
}

// MARK: - SelectDateDelegate

extension MovieFilterController: SelectDateDelegate {
    func pushYear(year: String) {
        // Update Year Value
        tableView.beginUpdates()
        rows[0] = FilterRows(title: "Date", value: year)
        let index = IndexPath(row: 0, section: 0)
        tableView.reloadRows(at: [index], with: .automatic)
        tableView.endUpdates()
    }
}

// MARK: - SelectGenreDelegate

extension MovieFilterController: SelectGenreDelegate {
    func pushGenre(genre: String) {
        // Update Year Value
        tableView.beginUpdates()
        rows[1] = FilterRows(title: "Genre", value: genre)
        let index = IndexPath(row: 1, section: 0)
        tableView.reloadRows(at: [index], with: .automatic)
        tableView.endUpdates()
    }
}
