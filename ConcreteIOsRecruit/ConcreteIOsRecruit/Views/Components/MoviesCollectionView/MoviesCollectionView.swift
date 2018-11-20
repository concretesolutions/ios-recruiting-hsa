//
//  MoviesCollectionView.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/19/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import UIKit

enum MoviesCollectionViewCellType : String{
    case MovieCollectionViewCell
    case MovieRowCollectionViewCell
}

protocol MoviesCollectionViewDelegate{
    func didTap(cell: MovieCollectionViewCell)
    func didTapFav(cell: MovieCollectionViewCell)
}

class MoviesCollectionView: UIView {
    var delegate : MoviesCollectionViewDelegate? = nil
    var cellReuseId : MoviesCollectionViewCellType = .MovieCollectionViewCell
    //let favorites = DataManager().retrieve(decodingType: Favorites.self, storingKey: Favorites().key)
    @IBOutlet weak var collectionView: UICollectionView!
    
    var favoritesDataManger = FavoritesDataManger()
    var movies : [Movie] = [Movie]() {
        didSet{
            //reload the favorite movies from local storage
            favoritesDataManger = FavoritesDataManger()
            self.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        fromNib()
        let cellNib = UINib(nibName: cellReuseId.rawValue, bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: cellReuseId.rawValue)
    }
}

extension MoviesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId.rawValue, for: indexPath) as?  MovieCollectionViewCell {
            var movie = self.movies[indexPath.row]
            cell.delegate = self //sets the delegate so we are able to receive touch events from the cells
            
            //check if movie should be marked as favorite
            if favoritesDataManger.isAlreadyInFavorites(movie: movie){
                movie.isFavorite = true
            }
            
            cell.movie = movie
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.cellReuseId {
        
        case .MovieCollectionViewCell:
            return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3)
        case .MovieRowCollectionViewCell:
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //pass the cell to the delegate
        if let cell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell{
            delegate?.didTap(cell: cell)
        }
    }
}

extension MoviesCollectionView: MovieCollectionViewCellDelegate{
    func didTapFavIcon(cell: MovieCollectionViewCell) {
        if let movie = cell.movie{
            switch favoritesDataManger.addRemoveMovie(movie: movie){
            case .added:
                cell.updateFavIcon(favoriteIconIsOn: true)
            case .removed:
                cell.updateFavIcon(favoriteIconIsOn: false)
            }
        }
        //pass the tap acition to the delegate of this view in case we need to perform any other action
        delegate?.didTapFav(cell: cell)
    }
}
