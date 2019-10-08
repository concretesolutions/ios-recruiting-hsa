//
//  MovieResumeTableViewCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/4/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit
import Nuke

class MovieResumeTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var overViewLb: UILabel!
    @IBOutlet weak var rateImg: UIImageView!
    @IBOutlet weak var voteLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyle()
    }


    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func updateInfo(movie: MovieModel){
        
        if let releaseYear = TimeHelper.getYearFromDate(dateString: movie.releaseDate){
            titleLb.text = "\(movie.title) (\(releaseYear))"
        }else{
            titleLb.text = movie.title
        }
        
        if let url = movie.getBackDropImageURL(withSize: .w780){
            Nuke.loadImage(with: url, into: imgView)
        }
       
        overViewLb.text = movie.overview
        
        shadowView.setupShadow()
        voteLb.text = "\(movie.voteAverage)/ 10"
        rateImg.image = movie.voteAverage < 5.0 ? .handDownIc : .handUpIc
        rateImg.tintColor = UIColor.ratingColor(ratingApproval: movie.getApprovalRating())
    }
    
    func setStyle(){
        backgroundColor = .appBackgroundColor
        imgView.roundBorder(radius: 5.0)
        titleLb.font = UIFont.systemFont(ofSize: 19, weight: .light)
        overViewLb.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        rateImg.contentMode = .scaleAspectFit
    }
    
}
