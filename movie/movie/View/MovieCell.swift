 //
//  MovieCell.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 22/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieLbl: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    func configureCell(movie : Movies) {
        let MovieTitle = movie.title ?? ""
        movieLbl.text = MovieTitle
        
        print("Entrou")
        
        favoriteBtn.isHidden = false
        
        let pathImage = String(movie.poster_path) ?? ""
        let Image = "\(URL_IMG)\(pathImage)" ?? ""
        print (Image)
        let url = URL(string: Image)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            movieImage.image = UIImage(data: imageData)
        }
        
        /* code for date:
        guard var isoDate = message.timeStamp else { return }
        let end = isoDate.index(isoDate.endIndex, offsetBy: -5)
        isoDate = isoDate.substring(to: end)
        
        let isoFormatter = ISO8601DateFormatter()
        let chatDate = isoFormatter.date(from: isoDate.appending("Z"))
        
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        
        if let finalDate = chatDate {
            let finalDate = newFormatter.string(from: finalDate)
            timeStampLbl.text = finalDate
        }*/
        
        
    }//ConfigureCell
    
}
