//
//  FavoriteMovieTableViewCell.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit
import Nuke

class FavoriteMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        backgroundColor = .lightGray
    }
    
    func updateInfo(item: LocalMovieModel){
        title.text = item.title
        year.text = TimeHelper.getYearFromDate(dateString: item.releaseDate)
        overview.text = item.overview
        if let url = item.getPosterImageURL(withSize: .w780){
            Nuke.loadImage(with: url, into: movieImage)
        }
    }
    
}
