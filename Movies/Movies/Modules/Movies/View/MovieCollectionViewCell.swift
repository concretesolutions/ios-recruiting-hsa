//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Alfredo Luco on 05-02-21.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumb: UIImageView!
    
    //MARK: - Variables
    
    weak var movie: Movie? {
        didSet {
            guard let value = movie else { return }
            if let url = URL(string: Constants.mediaURL + "/w500/\(value.poster_path ?? "")") {
                thumb.load(url: url)
            }
            self.nameLabel.text = value.title
            self.starButton.setImage(value.starred ? UIImage(named: "ic_star_fill") : UIImage(named: "ic_star_on"), for: .normal)
        }
    }
    
    //MARK: - Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.starButton.addTarget(self, action: #selector(star), for: .touchUpInside)
        // Initialization code
    }
    
    //MARK: - Selectors
    
    @objc func star() {
        let flag = !(movie?.starred ?? false)
        self.starButton.setImage(flag ? UIImage(named: "ic_star_fill") : UIImage(named: "ic_star_on"), for: .normal)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        do {
            movie?.starred = flag
            try appDelegate.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }

}
