//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import UIKit

// MARK: - Movie
class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favorite: UIImageView!
    private let cache = NSCache<NSNumber, UIImage>()

    func configurate(movie: Movie) {
        title.text = movie.title

        if let cachedImage = self.cache.object(forKey: Int(movie.id) as NSNumber) {
            print("Using a cached image for item: \(movie.id)")
            poster.image = cachedImage
        } else {
            guard let image = UIImage(named: "Search") else {return}
            poster.imageFromServerURL(urlString: APIUrl.routeImage + (movie.posterPath),
                                      placeHolderImage: image) { result in
                if result == "OK" {
                    if let img = self.poster.image {
                        self.cache.setObject(img, forKey: movie.id as NSNumber)
                    }
                }
            }
            /*poster.loadFrom(URLAddress: APIUrl.routeImage + (movie.posterPath)) {
                if result == "OK" {
                    if let img = self.poster.image {
                        self.cache.setObject(img, forKey: movie.id as NSNumber)
                    }
                }
            }*/
        }

        if movie.favorite == true {
            favorite.image = UIImage(named: "FavoriteFull")
            } else {
                favorite.image = UIImage(named: "FavoriteEmpty")
            }
    }
}
