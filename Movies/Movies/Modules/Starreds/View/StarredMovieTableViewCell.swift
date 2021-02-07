//
//  StarredMovieTableViewCell.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import UIKit

class StarredMovieTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
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
            self.yearLabel.text = String(value.release_date?.split(separator: "-").first ?? "")
            self.summaryLabel.text = value.overview
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
