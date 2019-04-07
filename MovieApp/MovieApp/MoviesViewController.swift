//
//  MoviesViewController.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/4/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit

protocol MoviesViewProtocol : class {
    func showMovies(movies: [MovieViewModel])
    
}

class MoviesViewController: UIViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModels : [MovieViewModel] = []
    var presenter : MoviePresenter!
    var interactor : MovieInteractor!
    var router : MovieRouter!
    
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(top: 50.0,left: 20.0,bottom: 50.0,right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = MovieInteractor()
        self.router = MovieRouter(presentingViewController: self)
        self.presenter = MoviePresenter(movieInteractor: interactor, movieRouter: router)
        self.presenter.attachView(view: self)
        self.interactor.presenter = presenter
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName:"MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MOVIECOLLECTIONCELL")
        
        presenter.fetchMovies()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModels = presenter.matchMovieWithFavorite(viewModels: viewModels)
        collectionView.reloadData()
    }
    
}

extension MoviesViewController : MoviesViewProtocol {
    func showMovies(movies: [MovieViewModel]) {
        self.viewModels = movies
        self.collectionView.reloadData()
    }
}

extension MoviesViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MOVIECOLLECTIONCELL", for: indexPath) as! MovieCollectionViewCell
        cell.viewModel = viewModels[indexPath.row]
        cell.titleMovieLabel .text = viewModels[indexPath.row].title
        cell.favoriteImage.image = viewModels[indexPath.row].favorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
        cell.downloadImage()
        return cell
    }
}

extension MoviesViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        presenter.showMovieDetail(for: viewModels[indexPath.row])
    }
}

extension MoviesViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}




