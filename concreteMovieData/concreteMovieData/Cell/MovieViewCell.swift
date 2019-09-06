//
//  MovieViewCell.swift
//  concreteMovieData
//
//  Created by Christopher Parraguez on 9/5/19.
//  Copyright © 2019 Christopher Parraguez. All rights reserved.
//

import UIKit

class MovieViewCell: UICollectionViewCell {

    @IBOutlet fileprivate var posterMovieImage: UIImageView!
    @IBOutlet fileprivate var nameMovieText: UILabel!
    @IBOutlet fileprivate var favouriteButton: UIButton!
    var movieData:MovieResponse!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var movie: MovieResponse? {
        didSet{
            self.movieData = movie
        }
    }
    var title: String? {
        didSet {
            self.nameMovieText.text = title
        }
    }
    var urlImage: String? {
        didSet {
            debugPrint(BASE_IMAGE_URL+urlImage!)
            self.posterMovieImage.dowloadFromServer(link: BASE_IMAGE_URL+urlImage!, contentMode: .scaleToFill)
        }
    }
    @IBAction func favouriteButtonAction(_ sender: Any) {
        debugPrint("click heart")
        if let image = UIImage(named: "favorite_full_icon") {
            self.favouriteButton.setImage(image, for: .normal)
        }
    }
}
extension UIImageView {
    func dowloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func dowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(url: url, contentMode: mode)
    }
}
