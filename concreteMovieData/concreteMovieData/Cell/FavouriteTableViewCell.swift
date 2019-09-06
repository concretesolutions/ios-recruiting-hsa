//
//  FavouriteTableViewCell.swift
//  concreteMovieData
//
//  Created by Christopher Parraguez on 9/6/19.
//  Copyright © 2019 Christopher Parraguez. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet fileprivate var favouriteImage: UIImageView!
    @IBOutlet fileprivate var favouriteName: UILabel!
    @IBOutlet fileprivate var favouriteDate: UILabel!
    @IBOutlet fileprivate var favouriteOverView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var name: String? {
        didSet {
            self.favouriteName.text = name
        }
    }
    var urlImage: String? {
        didSet {
            debugPrint(BASE_IMAGE_URL+urlImage!)
            self.favouriteImage.dowloadFromServer(link: BASE_IMAGE_URL+urlImage!, contentMode: .scaleToFill)
        }
    }
    var date: String? {
        didSet {
            self.favouriteDate.text = date
        }
    }
    
    var overview: String? {
        didSet {
            self.favouriteOverView.text = overview
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
