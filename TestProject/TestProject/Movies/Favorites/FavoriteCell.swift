//
//  FavoriteCell.swift
//  TestProject
//
//  Created by Felipe S Vergara on 21-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    
    
    
    var favorite:Movie?{
        didSet{
            render()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func render(){
        if let favoriteMovie = favorite{
            movieImage.kf.setImage(with: favoriteMovie.getUrlImage())
            movieTitle.text = favoriteMovie.title
            movieDate.text = formatDateFrom(dateToFormat: favoriteMovie.releaseDate)
            movieOverview.text = favoriteMovie.overview
        }
    }
    
    func formatDateFrom(dateToFormat:String) -> String{
        var formattedDate = ""
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy"
        
        if let date = dateFormatterGet.date(from: dateToFormat) {
            formattedDate = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        
        return formattedDate
    }

}
