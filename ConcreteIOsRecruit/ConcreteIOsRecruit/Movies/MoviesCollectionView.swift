//
//  MoviesCollectionView.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/19/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import UIKit

class MoviesCollectionView: UIView {
    
    let cellReuseId = "MovieCollectionViewCell"
    @IBOutlet weak var collectionView: UICollectionView!
    var movies : [Movie] = [Movie]() {
        didSet{
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
        let cellNib = UINib(nibName: cellReuseId, bundle: nil)
        self.collectionView.register(cellNib, forCellWithReuseIdentifier: cellReuseId)
    }

}

extension MoviesCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as?  MovieCollectionViewCell {
            cell.movie = self.movies[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2, height: UIScreen.main.bounds.height/3)
    }
    
}
