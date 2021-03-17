//
//  DetailMovieViewController.swift
//  movs
//
//  Created by Carlos Petit on 13-03-21.
//

import UIKit

class DetailMovieViewController: UIViewController {

    var selectedMovie: MovieViewModel?
    var ModelView: MoviesViewModel?
    var selectedMovieIndex = 0
    
    @IBAction func FavoritePressButtonAction(_ sender: UIButton) {
        ModelView?.favorite(at: selectedMovieIndex)
        let isFavorite = ModelView?.item(at: selectedMovieIndex).favorite
        sender.setImage(UIImage(systemName: isFavorite! ? "heart.fill":"heart"), for: .normal)
       
    }
    
    
    @IBOutlet weak var imageViewDetail: UIImageView!
    @IBOutlet weak var titleViewDetail: UILabel!
    @IBOutlet weak var favoriteButtonViewDetail: UIButton!
    @IBOutlet weak var yearViewDetail: UILabel!
    @IBOutlet weak var genderViewDetail: UILabel!
    @IBOutlet weak var descriptionViewDetail: UITextView!
    
    private var genreViewModel = GenresViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewDetail.load(url: selectedMovie!.image)
        imageViewDetail.contentMode = .scaleToFill
        titleViewDetail.text = selectedMovie?.title
        yearViewDetail.text = selectedMovie?.year
        genderViewDetail.text = genreViewModel.getGenres(ids: selectedMovie!.gender)
        descriptionViewDetail.text = selectedMovie?.description
        favoriteButtonViewDetail.setImage(UIImage(systemName: selectedMovie!.favorite ? "heart.fill" :"heart"), for: .normal)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

