//
//  MovieListViewController + UICollectionViewDataSourceDelegate.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/10/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering() ? viewModel.filteredList.count : viewModel.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieMediaCollectionViewCell.reuseIdentifier, for: indexPath)
        
        let movie = isFiltering() ? viewModel.filteredList[indexPath.row] : viewModel.movieList[indexPath.row]
        if let cell = cell as? MovieMediaCollectionViewCell{
            cell.updateInfo(movieItem: movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard !isFiltering() else { return }
        
        if indexPath.row == viewModel.movieList.count - 1 && viewModel.canLoadMore{
            viewModel.currentPage += 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 3
        let cellHeight = collectionView.frame.height / 3.7
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showDetailMovie(atIndex: indexPath.row, filteringResults: isFiltering())
    }
    
}

