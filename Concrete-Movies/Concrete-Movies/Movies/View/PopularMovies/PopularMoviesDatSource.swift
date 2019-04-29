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
        return viewController?.moviesList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewController = viewController,
            let movies = viewController.moviesList,
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesConstants.movieCellIdentifier, for: indexPath) as? MovieCollectionViewCell
            else {return UICollectionViewCell()}
        
        
        customCell.setup(movie: movies[indexPath.row])
        
        return customCell
    }
    
    
}
