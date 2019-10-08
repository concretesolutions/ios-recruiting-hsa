//
//  HomeMovieViewController.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/2/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

class HomeMovieViewController: UIViewController, UISearchBarDelegate, HomeMovieDelegate, HomeViewModelDelegate {
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorLb: UILabel!
    
    let viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        view.backgroundColor = .appBackgroundColor
        viewModel.delegate = self
        viewModel.fetchData()
        
    }

    func setupSearchBar(){
        
        self.title = "MovieScope"
        self.definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        let searchController = UISearchController.init(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search for movies..."
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.tintColor = .white
        searchController.searchBar.delegate = self
        
        if #available(iOS 11.0, *){
            navigationItem.searchController = searchController
        }else{
            navigationItem.titleView = searchController.searchBar
        }
    }
    
    func setHideErrorLb(isHidden: Bool){
        errorLb.isHidden = isHidden
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let queryText = searchBar.text else { return }
        self.viewModel.searchMovie(query: queryText)
    }
    
    /* Delegate */
    func showMovieDetail(movieId: Int) {
        self.viewModel.showDetail(forMovie: movieId)
    }
    
    func onLoadingStatus(isLoading: Bool) {
        if isLoading{
            setHideErrorLb(isHidden: true)
            tableView.addLoadingAnimation(tintColor: .white)
        }else{
            tableView.removeAnimateHolders()
        }
    }
    
    func onSectionsUpdated(sectionList: [HomeSection]) {
        tableView.reloadData()
        let shouldHideError = sectionList.count > 0
        setHideErrorLb(isHidden: shouldHideError)
    }
    
    func onErrorMsg(errorMsg: String) {
        self.displayAlertMsg(msg: errorMsg)
    }
    
    //Some boilerplate for the status bar
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

