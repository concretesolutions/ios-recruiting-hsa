//
//  MovieDetailViewController.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/5/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import UIKit

protocol MovieDetailViewControllerDelegate: class {
    
    func movieDetailDismiss()
    
}

class MovieDetailViewController: BaseViewController {
    
    @IBOutlet weak var blurVisualEffectView: UIVisualEffectView!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var effect: UIVisualEffect!
    
    var delegate: MovieDetailViewControllerDelegate!
    var movie = Movie()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        effect = blurVisualEffectView.effect
        blurVisualEffectView.effect = nil
        cardView.alpha = 0
        
        let blurViewTap = UITapGestureRecognizer(target: self, action: #selector(self.blurViewTap(_:)))
        blurVisualEffectView.addGestureRecognizer(blurViewTap)
        
        let favoriteTap = UITapGestureRecognizer(target: self, action: #selector(self.favoriteTap(_:)))
        favoriteImageView.addGestureRecognizer(favoriteTap)

        titleLabel.text = movie.name
        
        if movie.isFavorite {
            
            favoriteImageView.image = UIImage(named:"icon_favorite_full")
            
        } else {
            
            favoriteImageView.image = UIImage(named:"icon_favorite_gray")
            
        }
        
        let url = URL(string: movie.pictureURL)
        pictureImageView.kf.setImage(with: url!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        dateLabel.text = dateFormatter.string(from: movie.date)
        
        var genresText = ""
        
        for index in 0..<movie.genres.count {
            
            if index == 0 {
                
                genresText = "\(movie.genres[index].name)"
                
            } else {
                
                genresText = "\(genresText), \(movie.genres[index].name)"
            }
        }
        
        genresLabel.text = genresText
        descriptionLabel.text = movie.movieDescription
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        animateIn()
        
    }
    
    @objc func favoriteTap(_ sender: UITapGestureRecognizer) {
        
        try! realm.write {
            
            movie.isFavorite = !movie.isFavorite
            
        }
        
        if movie.isFavorite {
            
            favoriteImageView.image = UIImage(named:"icon_favorite_full")
            
        } else {
            
            favoriteImageView.image = UIImage(named:"icon_favorite_gray")
            
        }
    }
    
    func animateIn(){
        
        cardView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.blurVisualEffectView.effect = self.effect
            self.cardView.alpha = 1
            self.cardView.transform = CGAffineTransform.identity
        })
    }
    
    
    func animateOut() {
        
        UIView.animate(withDuration: 0.4, animations: {
            
            self.blurVisualEffectView.effect = nil
            
            self.cardView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            
            self.cardView.alpha = 0
            
        }, completion: { (success: Bool) in
            
            self.dismiss(animated: false, completion: {
                
                self.delegate.movieDetailDismiss()
                
            })
        })
    }
    
    @objc func blurViewTap(_ sender: UITapGestureRecognizer) {
        
        animateOut()
        
    }
}

