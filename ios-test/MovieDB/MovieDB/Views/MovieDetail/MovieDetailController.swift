//
//  MovieDetailController.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/7/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import UIKit

struct TableRows {
    let text: String
}

class MovieDetailController: UIViewController {
    var detailViewModel: MovieDetailViewModel?
    var movieViewModel: MovieViewModel! {
        didSet {
            detailViewModel = MovieDetailViewModel(movieID: movieViewModel.id)
            title = movieViewModel.originalTitle
            rows = movieViewModel.detailRows(viewModel: movieViewModel)
        }
    }

    var tableView = UITableView()
    var rows = [MovieCellRows]()
    let cell_image_id = "cell_image_id"
    let cell_text_id = "cell_text_id"

    func startSpinner() {
    }

    func stopSpinner() {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTableView()

        // Fetch Recent Movies
        detailViewModel?.fetchMovie()

        // Update UI with Error if Any
        detailViewModel?.showAlertClosure = {
            if let error = self.detailViewModel?.error {
                print(error.localizedDescription)
            }
        }

        // Update UI with new fetch data if Any
        detailViewModel?.didFinishFetch = {
            self.tableView.beginUpdates()
            self.rows[3] = (self.detailViewModel?.getGenres())!
            let index = IndexPath(row: 3, section: 0)
            self.tableView.reloadRows(at: [index], with: .automatic)
            self.tableView.endUpdates()
        }
    }

    func setupTableView() {
        // Define tableview cells on table
        tableView.register(MovieDetailTextCell.self, forCellReuseIdentifier: cell_text_id)
        tableView.register(MovieDetailImageCell.self, forCellReuseIdentifier: cell_image_id)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.frame = view.frame
        view.addSubview(tableView)
    }
}

extension MovieDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]

        if row.rowType == .isImage {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell_image_id, for: indexPath) as! MovieDetailImageCell
            cell.viewModel = row
            return cell

        } else if row.rowType == .isText {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell_text_id, for: indexPath) as! MovieDetailTextCell
            cell.viewModel = row
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
