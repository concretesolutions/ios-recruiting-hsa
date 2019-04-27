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
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesConstants.movieCellIdentifier, for: indexPath) as! MovieCollectionViewCell
        
        return cell
    }
    
    
}
