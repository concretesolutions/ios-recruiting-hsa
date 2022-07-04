//
//  SingleMovieViewController.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 30-06-22.
//

import UIKit
import SkeletonView



class SingleMovieViewController: UIViewController {
    
    @IBOutlet weak var titleMovieLabel : UILabel!
    @IBOutlet weak var descriptionTextView : UITextView!
    @IBOutlet weak var anioLabel : UILabel!
    @IBOutlet weak var generoLabel : UILabel!
    @IBOutlet weak var pictureImageView : UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    var Movie : MovieResult?
    var nameGenre : [String] = []
    let userDefaults = UserDefaults.standard
    var idsFavoriteMovies : [Int] = FavManagerSingleton.shared.idsFavoriteMovies
    var currentMovie : MovieResult?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSekeleton()
        if chekMovie(){
            setupUI()
        }else{
            self.titleMovieLabel.showAnimatedGradientSkeleton()
            self.anioLabel.showAnimatedGradientSkeleton()
            self.descriptionTextView.showAnimatedGradientSkeleton()
            self.pictureImageView.showAnimatedGradientSkeleton()
            print("falla la en la carga")
        }

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        for idFavoriteMovie in idsFavoriteMovies{
            if(idFavoriteMovie == currentMovie!.id){
                //Esta pelicula es favorita
                self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }

        
    }
    
    private func setupUI(){
 
        self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        self.titleMovieLabel.showAnimatedGradientSkeleton()
        self.anioLabel.showAnimatedGradientSkeleton()
        self.descriptionTextView.showAnimatedGradientSkeleton()
        self.pictureImageView.showAnimatedGradientSkeleton()
        
        let apiManager = APIManager()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            
            self.titleMovieLabel.hideSkeleton()
            self.anioLabel.hideSkeleton()
            self.descriptionTextView.hideSkeleton()
            self.pictureImageView.hideSkeleton()
            
            self.titleMovieLabel.text = self.currentMovie!.title
            
            let myDate = Date()
            self.anioLabel.text = myDate.getYearFromString(dateString : self.currentMovie!.release_date)
            self.descriptionTextView.text = self.currentMovie!.overview
            
            self.pictureImageView.downloaded(from: Endpoints.images +  self.currentMovie!.poster_path )
            self.pictureImageView.contentMode = .scaleAspectFill
            
            apiManager.getGenres { Genres in
                guard let generos = Genres else { return }

                for id in self.currentMovie!.genre_ids{
                    for genre in generos.genres{
                        if genre.id == id{
                            self.generoLabel.text = (self.generoLabel.text ?? "") + " \(genre.name),"
                        }

                    }
                }
                
            }

        }

    }
    
    
    @IBAction func favOnTap(_ sender: Any) {
        
        guard let movie = Movie else {return }
        
        FavManagerSingleton.shared.addMovieToFavorites(movie: movie)
        self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    
    private func setupSekeleton(){
        self.titleMovieLabel.isSkeletonable = true
        self.anioLabel.isSkeletonable = true
        self.descriptionTextView.isSkeletonable = true
        self.pictureImageView.isSkeletonable = true
    }
    
    
    private func chekMovie() -> Bool{
        
        guard let movie = Movie else { return false }
        currentMovie = movie
        return true
    }

}
