//
//  MovieDetailViewController.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/5/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit
import WebKit
import Nuke

class MovieDetailViewController: UIViewController, MovieDetailDelegate, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var contentControl: UISegmentedControl!
    @IBOutlet weak var errorLb: UILabel!
    @IBOutlet weak var genreCollectionViewLayout: UICollectionViewFlowLayout!{
        didSet {
            genreCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    let viewModel: MovieDetailViewModel
    var currentDataSource: MovieDetailTableViewDataSource?
    
    init(viewModel: MovieDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentControl.addTarget(self, action: #selector(reloadTableView(_:)), for: .valueChanged)
        view.backgroundColor = .appBackgroundColor
        viewModel.delegate = self
        setupCollectionView()
        setupTableView()
        viewModel.fetchMovieData()
    }
    
    func setupTableView(){
        tableView.estimatedSectionHeaderHeight = 54
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .appBackgroundColor
        tableView.register(UINib.init(nibName: MovieDetailFeatureTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieDetailFeatureTableViewCell.reuseIdentifier)
        tableView.register(UINib.init(nibName: MovieMediaImageTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieMediaImageTableViewCell.reuseIdentifier)
        tableView.register(UINib.init(nibName: MovieMediaVideoTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: MovieMediaVideoTableViewCell.reuseIdentifier)
        tableView.register(MovieMediaTableViewHeader.self, forHeaderFooterViewReuseIdentifier: MovieMediaTableViewHeader.reuseIdentifier)
        
    }
    
    
    func onDataUpdate(movie: MovieDetailModel) {
        
        if let imgURL = movie.getPosterPathImageURL(){
            Nuke.loadImage(with: imgURL, into: posterImg)
        }else{
            posterImg.image = .notFoundImage
        }
        setTitle(movie: movie)
        genresCollectionView.reloadData()
        reloadTableView(self.contentControl)
        
    }
    
    func setTitle(movie: MovieDetailModel){
        if let releaseYear = TimeHelper.getYearFromDate(dateString: movie.releaseDate){
            nameLb.text = "\(movie.title) (\(releaseYear))"
        }else{
            nameLb.text = movie.title
        }
    }
    
    func onLoadingStatus(isLoading: Bool) {
        if isLoading{
            errorLb.isHidden = true
            tableView.addLoadingAnimation(tintColor: .white)
        }else{
            tableView.removeAnimateHolders()
        }
    }
    
    func onMediaUpdate(movieMedia: MovieMediaModel) {
        reloadTableView(self.contentControl)
    }
    
    func onErrorHandler(error: Error) {
        displayErrorLb(msg: error.localizedDescription)
    }
    
    func displayErrorLb(msg: String){
        errorLb.isHidden = false
        errorLb.text = "Oops some error happened...\n Error: '\(msg)' \n Please try again. You can reload pulling the tab or exit using the back button then re-entry to this movie"
    }
    
    @objc func reloadTableView(_ sender: UISegmentedControl){
        let currentIndex = sender.selectedSegmentIndex
        self.currentDataSource = viewModel.getTableViewDataSource(forSelectedIndex: currentIndex)
        tableView.dataSource = currentDataSource
        tableView.reloadData()
    }
    
    /* Delegate functions */
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dataSource = currentDataSource as? MovieDetailMediaDataSource else{
            return nil
        }
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieMediaTableViewHeader.reuseIdentifier) as! MovieMediaTableViewHeader
        
        let mediaSection = dataSource.sections[section]
        header.titleLb.text = "\(mediaSection.title) (\(mediaSection.mediaSourceList.count))"
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      
        if currentDataSource is MovieDetailMediaDataSource{
            return UITableView.automaticDimension
        }
       
        return 0.0
    }

}
