//
//  UpComingMoviesTableViewCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/5/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

class UpComingMoviesTableViewCell: UITableViewCell, HomeConfigurableCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
   
    var viewModel: HomeCellViewModel?
    var delegate: HomeMovieDelegate?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setViewModel(viewModel: HomeCellViewModel) {
        
        self.viewModel = viewModel
        self.collectionView.reloadData()
        let height = self.collectionView.collectionViewLayout.collectionViewContentSize.height
        self.collectionViewHeight.constant = height
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}

extension UpComingMoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func setupCollectionView(){
        
        collectionView.backgroundColor = .appBackgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        let cellIdentifier = WideScreenMovieCollectionViewCell.reuseIdentifier
        collectionView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movieList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WideScreenMovieCollectionViewCell.reuseIdentifier, for: indexPath)
        
        if let movieCell = cell as? WideScreenMovieCollectionViewCell, let movie = viewModel?.movieList[indexPath.row]{
            movieCell.updateInfo(movie: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        guard let movie = viewModel?.movieList[indexPath.row] else {
            print("Error al seleccionar pelicula")
            return
        }
        delegate?.showMovieDetail(movieId: movie.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = UIScreen.main.bounds.width
        let itemHeight = collectionView.frame.size.height
        return CGSize.init(width: itemWidth, height: itemHeight)
    }
    
    
}
