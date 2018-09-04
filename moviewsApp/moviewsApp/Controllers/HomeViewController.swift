//
//  ViewController.swift
//  moviewsApp
//
//  Created by carlos jaramillo on 8/29/18.
//  Copyright © 2018 carlos jaramillo. All rights reserved.
//

import UIKit

class homeViewController: UIViewController {

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var moviesCollection: UICollectionView!
    @IBOutlet weak var cloud: UIImageView!
    @IBOutlet weak var message: UILabel!
    
    lazy var refreshControl: UIRefreshControl = UIRefreshControl()
    
    var moviesData : [Movie] = []
    var numPages : Int = 1
    var currentPage : Int = 1
    var currentTextSearch : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshDataMovies), for: UIControlEvents.valueChanged)
        if #available(iOS 10.0, *) {
            self.moviesCollection.refreshControl = self.refreshControl
        } else {
            self.moviesCollection.addSubview(self.refreshControl)
        }
        
        self.search.changeSearchBarColor(color: UIColor(named: "orangeColor")!)
        
        self.setupDelegates()
        self.loadMoviesData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Movies"
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.isTranslucent = false
        self.moviesCollection.reloadData()
    }
    
    
    /// recarga la data del collection cuando se ejecuta el refresh
    @objc func refreshDataMovies(){
        self.refreshControl.beginRefreshing()
        self.cloud.isHidden = true
        self.message.isHidden = true
        self.currentPage = 1
        self.numPages = 1
        self.loadMoviesData()
    }
    
    override func setupDelegates(){
        self.search.delegate = self
        self.moviesCollection.delegate = self
        self.moviesCollection.dataSource = self
    }
    
    
    /// carga la data del collection que trae del servicio
    func loadMoviesData(){
        if self.currentPage > self.numPages{
            return
        }
        if currentPage == 1{
            self.moviesData.removeAll()
            self.moviesCollection.reloadData()
            self.showIndicator()
        }
        API.shared.getMovies(page: self.currentPage , text: self.currentTextSearch) { (success, movies, totalPages, totalResults) in
            if self.currentPage == 1{
                DispatchQueue.main.async {
                    self.hideIndicator()
                    self.refreshControl.endRefreshing()
                }
            }
            if success{
                var indexpaths : [IndexPath] = []
                
                self.moviesData = self.moviesData + movies!
                self.currentPage += 1
                self.numPages = totalPages!
                
                if self.moviesCollection.numberOfItems(inSection: 0) == 0 {
                    self.moviesCollection.reloadData()
                }
                else{
                    for i in self.moviesCollection.numberOfItems(inSection: 0) ..< self.moviesData.count{
                        indexpaths.append(IndexPath(row: i, section: 0))
                    }
                    
                    DispatchQueue.main.async {
                        self.moviesCollection.insertItems(at: indexpaths)
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    self.view.makeToast("error Connection")
                }
                if self.moviesData.isEmpty != true{
                    DispatchQueue.main.async {
                        let indexpath = IndexPath(row: self.moviesCollection.numberOfItems(inSection: 0) - 2, section: 0)
                        self.moviesCollection.scrollToItem(at: indexpath, at: .top, animated: true)
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.cloud.isHidden = false
                        self.message.isHidden = false
                    }
                }
            }
        }
    }
}


extension homeViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        self.currentPage = 1
        self.numPages = 1
        self.currentTextSearch = searchBar.text!
        self.moviesCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        self.loadMoviesData()
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return !((searchBar.text?.count == 0 || searchBar.text?.last == " ") && text == " ")
    }
}

extension homeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        let size = self.view.frame
        if self.moviesData.count > 0{
            return CGSize(width: size.width, height:  50)
        }
        return CGSize(width: size.width, height: 0)
    }
}

extension homeViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.goToMovieDetail(movie: self.moviesData[indexPath.row])
    }
}

extension homeViewController : UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movie-cell", for: indexPath) as! MovieCollectionViewCell
        
        cell.nameMovie.text = self.moviesData[indexPath.row].title
        cell.likeButton.tintColor = Movie.favorites.filter({$0.id == self.moviesData[indexPath.row].id!}).count > 0 ? UIColor(named: "principalColor") : .white
        cell.delegate = self
        guard let posterPath = self.moviesData[indexPath.row].posterPath else {
            return cell
        }
        cell.moviePoster.loadPicture(of: "\(baseURLS.posters.rawValue)\(posterPath)")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moviesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer-activity", for: indexPath)
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.moviesCollection.frame
        return CGSize(width: size.width/2 - 15/2, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if view is activityFooterCollectionReusableView && self.currentPage > 1{
            self.loadMoviesData()
        }
    }
}



extension homeViewController : UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension homeViewController : MovieCollectionCellDelegate{
    
    func didAddFavorites(indexPath: IndexPath) {
        Movie.saveFavoriteMovie(movie: self.moviesData[indexPath.row])
        if #available(iOS 11.0, *) {
            self.moviesCollection.reloadItems(at: [indexPath])
        }
        else {
            self.moviesCollection.reloadData()
        }
    }
    
    func didremoveFavorites(indexPath: IndexPath) {
        Movie.removeFavoriteMovie(withID: self.moviesData[indexPath.row].id!)
        if #available(iOS 11.0, *) {
            self.moviesCollection.reloadItems(at: [indexPath])
        }
        else {
            self.moviesCollection.reloadData()
        }
    }
}
