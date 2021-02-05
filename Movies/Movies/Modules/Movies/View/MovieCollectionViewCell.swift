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
        }
    }
    
    //MARK: - Awake From Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
