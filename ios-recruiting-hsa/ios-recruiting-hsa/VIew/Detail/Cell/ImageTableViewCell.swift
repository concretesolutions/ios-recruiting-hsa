//
//  ImageTableViewCell.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

import AlamofireImage

class ImageTableViewCell: UITableViewCell {
    @IBOutlet
    private weak var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareViews()
    }
    
    private func prepareViews() {
        selectionStyle = .none
    }
    
    func configure(imageUrl: String?) {
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            movieImageView.af_setImage(withURL: url)
        }
    }
    
    override func prepareForReuse() {
        movieImageView.image = UIImage(named: "placeholder")
    }
}
