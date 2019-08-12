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
        if let imageUrl = imageUrl, !imageUrl.isEmpty, let url = URL(string: imageUrl) {
            movieImageView.af_setImage(withURL: url)
        } else {
            movieImageView.image = UIImage(named: "placeholder")
        }
    }
    
    override func prepareForReuse() {
        movieImageView.image = UIImage(named: "placeholder")
    }
}
