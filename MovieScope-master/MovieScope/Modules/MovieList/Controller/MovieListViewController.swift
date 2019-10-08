//
//  MoivieListViewController.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/9/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var errorLb: UILabel!
    
    let viewModel: MovieListViewModel
    let controllerTitle: String
    let searchController = UISearchController.init(searchResultsController: nil)
    
    init(viewModel: MovieListViewModel, title: String){
        self.viewModel = viewModel
        self.controllerTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = controllerTitle
        view.backgroundColor = .appBackgroundColor
        setupCollectionView()
        setupSearchBar()
        viewModel.delegate = self
    }
    func setupSearchBar(){
        
        definesPresentationContext = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search in \(controllerTitle) movies..."
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .white
        searchController.searchResultsUpdater = self
        if #available(iOS 11.0, *){
            navigationItem.searchController = searchController
        }else{
            navigationItem.titleView = searchController.searchBar
        }
        
    }
    
    func setupCollectionView(){
        collectionView.backgroundColor = .appBackgroundColor
        collectionView.register(UINib.init(nibName: MovieMediaCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: MovieMediaCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    //Wrapper para disponer el errorlb cuando se necesite
    func setHideErrorLb(isHidden: Bool){
        errorLb.isHidden = isHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension MovieListViewController: MovieListViewModelDelegate{

    func onDataUpdate(movies: [MovieModel]) {
        //Refresca el collectionview inmediatamente
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        let shouldHideError = movies.count > 0
        setHideErrorLb(isHidden: shouldHideError )
    }
    
    func onErrorMsg(errorMsg: String) {
        displayAlertMsg(msg: errorMsg)
    }
    
    func onLoadingStatus(isLoading: Bool) {
        if isLoading{
            setHideErrorLb(isHidden: true)
            collectionView.addLoadingAnimation(tintColor: .white)
        }else{
            collectionView.removeAnimateHolders()
        }
    }
    
}
