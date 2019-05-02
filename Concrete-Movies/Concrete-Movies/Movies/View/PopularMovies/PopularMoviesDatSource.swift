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
        
        //return viewController.searchActive ? viewController.filteredMoviesList.count : moviesList.count
        if(viewController.searchActive){
            return viewController.filteredMoviesList.isEmpty ? 1 : viewController.filteredMoviesList.count
        }else{
            return moviesList.isEmpty ? 1 : moviesList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        guard let viewController = viewController,
            let moviesList = viewController.moviesList else {return cell}
        
        if(viewController.searchActive){
            if(viewController.filteredMoviesList.isEmpty){
                cell = prepareEmptyCollectionCell(collectionView: collectionView, indexPath: indexPath, searching: true)
            }else{
                cell = prepareMovieCollectiionCell(collectionView: collectionView, indexPath: indexPath)
            }
        }else if(moviesList.isEmpty){
            cell = prepareEmptyCollectionCell(collectionView: collectionView, indexPath: indexPath, searching: false)
        }else{
            cell = prepareMovieCollectiionCell(collectionView: collectionView, indexPath: indexPath)
        }
        
        return cell
    }
    
    private func prepareMovieCollectiionCell(collectionView: UICollectionView, indexPath: IndexPath)->UICollectionViewCell{
        guard let viewController = viewController,
            let movies = viewController.moviesList,
            let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesConstants.movieCellIdentifier, for: indexPath) as? MovieCollectionViewCell
            else {return UICollectionViewCell()}
        
        if(viewController.searchActive){
            customCell.setup(movie: viewController.filteredMoviesList[indexPath.row], cellIndexPath: indexPath)
        }else{
            customCell.setup(movie: movies[indexPath.row], cellIndexPath: indexPath)
        }
        customCell.delegate = viewController
        
        return customCell
    }
    
    private func prepareEmptyCollectionCell(collectionView: UICollectionView, indexPath: IndexPath, searching: Bool)->UICollectionViewCell{
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMoviesConstants.emptyCellIdentifier, for: indexPath) as? EmptyMoviesCollectionViewCell else {return UICollectionViewCell()}
        
        cell.setup(searchFailed: searching)
        
        return cell
    }
    
}
