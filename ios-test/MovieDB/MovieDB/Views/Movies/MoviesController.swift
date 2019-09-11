//
//  MoviesController.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/6/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import os
import UIKit

class MoviesController: UIViewController {

    var shareView = MovieView()
    var dataSource = [MovieViewModel]()
    var viewModel = MovieViewModel(model: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        navigationItem.searchController = shareView.searchController
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func loadView() {
        shareView.dataSource = dataSource
        shareView.controller = self
        view = shareView
    }

    override func viewWillAppear(_ animated: Bool) {

        viewModel.updateLoadingStatus = {
            _ = self.viewModel.isLoading ? self.shareView.startSpinner() : self.shareView.stopSpinner()
        }

        viewModel.fetchMovies()

        viewModel.showAlertClosure = {
            self.shareView.displayState(message: "An Error Ocurred. Please, Try Again.",
                                        icon: "error_icon",
                                        visible: true)
        }

        viewModel.didFinishFetch = {
            self.shareView.dataSource = self.viewModel.movieArray!
        }
    }


}
