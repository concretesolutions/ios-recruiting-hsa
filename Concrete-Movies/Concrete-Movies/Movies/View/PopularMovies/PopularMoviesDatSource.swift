//
//  PopularMoviesDatSource.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/27/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import UIKit

class PopularMoviesDataSource: NSObject{
    weak var viewController: PopularMoviesViewController?
}

extension PopularMoviesDataSource: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewController = viewController,
            let moviesList = viewController.moviesList else {return 0}
        
        return viewController.searchActive ? viewController.filteredMoviesList.count : moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewController = viewController,
            let movies = viewController.moviesList,
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesConstants.movieCellIdentifier, for: indexPath) as? MovieCollectionViewCell
            else {return UICollectionViewCell()}
        
        if(viewController.searchActive){
            customCell.setup(movie: viewController.filteredMoviesList[indexPath.row])
        }else{
            customCell.setup(movie: movies[indexPath.row])
        }
        customCell.delegate = viewController
        
        return customCell
    }
    
    
}
