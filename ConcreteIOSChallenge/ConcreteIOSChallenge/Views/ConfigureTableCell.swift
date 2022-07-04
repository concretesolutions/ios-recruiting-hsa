//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Accenture on 27-06-22.
//

import UIKit

protocol ProtocolDetailsMovie: AnyObject {
    func viewDetailsMovie(_ cell: ConfigureTableCell, viewModel: MovieViewModel)
}

//ESTA CLASE CONFIGURA LAS CELDAS DE LA TABLA UITABLEVIEW
class ConfigureTableCell: UITableViewCell {

    static let identifier = "ConfigureTableCell"
    weak var delegate: ProtocolDetailsMovie?
    
    private var movies: [Movie] = [Movie]()
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 160, height: 220)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with movies: [Movie]){
        self.movies = movies
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension ConfigureTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell()
        }
        
        guard let model = movies[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
            
        cell.configure(width:model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        guard let titleName = movie.original_title ?? movie.original_title else {
            return
        }
        
        RestApi.shared.getMovie(with: titleName + " trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                
                let title = self?.movies[indexPath.row]
                guard let titleOverview = title?.overview else {
                    return
                }
                guard let releaseDate = title?.release_date else {
                    return
                }
                guard let strongSelf = self else {
                    return
                }
                let viewModel = MovieViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview,releaseDate: releaseDate)
                self?.delegate?.viewDetailsMovie(strongSelf, viewModel: viewModel)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
