//
//  MovieDetailViewController + UICollectionViewDataSource.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/7/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

extension MovieDetailViewController: UICollectionViewDataSource{
    
    func setupCollectionView(){
        genresCollectionView.backgroundColor = .clear
        genresCollectionView.register(UINib.init(nibName: "MovieDetailGenreCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: MovieDetailGenreCollectionViewCell.reuseIdentifier)
        genresCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentMovie?.genreList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieDetailGenreCollectionViewCell.reuseIdentifier, for: indexPath)
        
        if let cell = cell as? MovieDetailGenreCollectionViewCell, let genreList = viewModel.currentMovie?.genreList{
            cell.updateInfo(genreName: genreList[indexPath.row].name)
            cell.roundBorder(color: UIColor.white.cgColor, radius: 5.0)
        }
        
        return cell
    }
    
    
}
