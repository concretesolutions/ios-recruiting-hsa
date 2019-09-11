//
//  GenreController.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/8/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation
import UIKit

class GenreController: UIViewController {

    private var tableView = UITableView()
    private var indicator = UIActivityIndicatorView()
    private var genres = [GenreDictionary]()
    private var cell_id = "cell_id"
    var genreDelegate: SelectGenreDelegate!
    var viewModel = GenreViewModel()

    override func viewDidLoad() {
        self.title = "Genres"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cell_id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.frame = view.frame
        view.addSubview(tableView)

        viewModel.updateLoadingStatus = {
            _ = self.viewModel.isLoading ? self.startSpinner() : self.stopSpinner()
        }

        viewModel.fetchGenres()

        viewModel.didFinishFetch = {
            self.genres = self.viewModel.genreArray!
            self.tableView.reloadData()
        }

        viewModel.showAlertClosure = {
            self.genres = [GenreDictionary]()
            let movieView = MovieView()
            movieView.displayState(message: "An Error Ocurred. Please, Try Again.", icon: "error_icon", visible: true)
            self.tableView.reloadData()
        }
    }
}

extension GenreController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath)
        let current = self.genres[indexPath.row]
        cell.textLabel?.text = current.name
        return cell
    }
}

extension GenreController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let current = self.genres[indexPath.row]
        genreDelegate.pushGenre(genre: current.name)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Spinner

extension GenreController {
    func startSpinner() {

        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.translatesAutoresizingMaskIntoConstraints = false

        DispatchQueue.main.async {
            self.view.addSubview(self.indicator)
            self.indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
            self.indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }

        indicator.startAnimating()
        indicator.backgroundColor = UIColor.clear
    }

    func stopSpinner() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
}

// MARK: Protocol Genre

protocol SelectGenreDelegate {
    func pushGenre(genre: String)
}
