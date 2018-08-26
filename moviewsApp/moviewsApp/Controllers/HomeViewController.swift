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
    
    var moviesData : [Movie] = []
    var favorites : [Movie] = []
    var numPages : Int = 1
    var currentPage : Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showIndicator()
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
    
    func setupDelegates(){
        self.search.delegate = self
        self.moviesCollection.delegate = self
        self.moviesCollection.dataSource = self
    }
    
    func loadMoviesData(){
        if self.currentPage > self.numPages {
            return
        }
        API.shared.getMovies(page: self.currentPage) { (success, movies, totalPages, totalResults) in
            if self.currentPage == 1{
                self.hideIndicator()
            }
            if success{
                var indexpaths : [IndexPath] = []
                for i in self.moviesData.count ..< (movies?.count)! + self.moviesData.count{
                    indexpaths.append(IndexPath(row: i, section: 0))
                }
                self.moviesData = self.moviesData + movies!
                self.currentPage += 1
                self.numPages = totalPages!
                
                self.moviesCollection.insertItems(at: indexpaths)
            }
        }
    }
}


extension homeViewController : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return !((searchBar.text?.count == 0 || searchBar.text?.last == " ") && text == " ")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
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
        cell.likeButton.tintColor = Movie.favorites.filter({$0.id == self.moviesData[indexPath.row].id}).count > 0 ? UIColor(named: "principalColor") : .white
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
        Movie.favorites.append(self.moviesData[indexPath.row])
        if #available(iOS 11.0, *) {
            self.moviesCollection.reloadItems(at: [indexPath])
        }
        else {
            self.moviesCollection.reloadData()
        }
        self.updateFavoritesMovies()
    }
    
    func didremoveFavorites(indexPath: IndexPath) {
        Movie.favorites = Movie.favorites.filter({$0.id != self.moviesData[indexPath.row].id})
        if #available(iOS 11.0, *) {
            self.moviesCollection.reloadItems(at: [indexPath])
        }
        else {
            self.moviesCollection.reloadData()
        }
        self.updateFavoritesMovies()
    }
}
