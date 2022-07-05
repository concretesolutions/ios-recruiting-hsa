//
//  MovieCollectionViewCell.swift
//  tmdb-app
//
//  Created by training on 01-07-22.
//

import UIKit
import CoreData

class MovieCollViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieToFavs: UIButton!
    var movieId: String!
    var delegate: MyCellDelegate?
    var selectedMovie: PopularMovie!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let identifier = "MovieCollViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        guard let movId = movieId else {
            return
        }

        print("movie_selected: \(movId)")

        self.delegate?.cellWasPressed(selectedMovieId: movId)
    }
    
    public func configure(with movie: PopularMovie) {
        
        self.selectedMovie = movie
        
        if let urlImg : String = movie.backdropPath {
            print("movie_image_endpoint: \(Endpoints.imageBasePath + urlImg)")
            self.movieImage.downloaded(from: Endpoints.imageBasePath + urlImg)
            self.movieImage.contentMode = .scaleAspectFill
        }
    
        self.movieId = String(movie.id)
        self.movieName.text = movie.title
    }
    
    @IBAction func addFavorite(_ sender: UIButton) {
        
        /// ERROR in class AppDelegate: +entityForName: nil is not a legal NSManagedObjectContext parameter searching for entity name "MovFavTmdb"
        
//        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "MovFavTmdb", in: context)
//        let newMovFav = MovFavTmdb(entity: entity!, insertInto: context)
//        newMovFav.id = String(self.selectedMovie.id)
//        newMovFav.title = self.selectedMovie.title
//
//        do {
//
//            if ((sender.currentImage?.isEqual(UIImage(named: "favorite_gray_icon"))) != nil) {
//
//                try context.save()
//                favoriteList.append(newMovFav)
//                sender.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
//
//            } else {
//
//                context.delete(newMovFav)
//                favoriteList = favoriteList.filter {$0.id != newMovFav.id}
//                sender.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
//
//            }
//
//        }
//        catch {
//            print("Movie cannot be saved as favorite")
//        }

        
    }

    
}


