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
    var idsPopularMovies : [Int]?
    var currentMovie : MovieResult?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSekeleton()
        if chekMovie(), checkPopularMovies(){
            
            setupUI()
        }else{
            self.titleMovieLabel.showAnimatedGradientSkeleton()
            self.anioLabel.showAnimatedGradientSkeleton()
            self.descriptionTextView.showAnimatedGradientSkeleton()
            self.pictureImageView.showAnimatedGradientSkeleton()
            print("falla la en la carga")
        }
        
    }
    
    private func setupUI(){
        
        for idPopularMovie in idsPopularMovies!{
            if(idPopularMovie == currentMovie!.id){
                //Esta pelicula es favorita
                self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
        
        self.titleMovieLabel.showAnimatedGradientSkeleton()
        self.anioLabel.showAnimatedGradientSkeleton()
        self.descriptionTextView.showAnimatedGradientSkeleton()
        self.pictureImageView.showAnimatedGradientSkeleton()
        
        let apiManager = APIManager()
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            
            self.titleMovieLabel.hideSkeleton()
            self.anioLabel.hideSkeleton()
            self.descriptionTextView.hideSkeleton()
            self.pictureImageView.hideSkeleton()
            
            self.titleMovieLabel.text = self.currentMovie!.title
            self.anioLabel.text = self.currentMovie!.release_date
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
        
        idsPopularMovies!.append(movie.id)
        
        userDefaults.set(idsPopularMovies, forKey: "idsPopularMovies")
        userDefaults.synchronize()
        
        self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
    
    @IBAction func getDate(_ sender: Any) {
        guard let arr = userDefaults.object(forKey: "idsPopularMovies") as? [Int] else { return }
        
        print("Arreglo", arr)

    }
    
    private func setupSekeleton(){
        self.titleMovieLabel.isSkeletonable = true
        self.anioLabel.isSkeletonable = true
        self.descriptionTextView.isSkeletonable = true
        self.pictureImageView.isSkeletonable = true
    }
    
    private func checkPopularMovies() -> Bool {
        
        guard let popular = userDefaults.object(forKey: "idsPopularMovies") as? [Int] else { return false }
        idsPopularMovies = popular
        return true
        
    }
    
    private func chekMovie() -> Bool{
        
        guard let movie = Movie else { return false }
        currentMovie = movie
        return true
    }

}
