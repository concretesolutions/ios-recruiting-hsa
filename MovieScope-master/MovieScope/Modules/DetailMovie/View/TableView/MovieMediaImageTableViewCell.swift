//
//  MovieMediaImageTableViewCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/8/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit
import Nuke

class MovieMediaImageTableViewCell: UITableViewCell, MovieMediaConfigurableCell {
   
    @IBOutlet weak var imgView: UIImageView!
    
    var viewModel: MediaImageViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .appBackgroundColor
        imgView.backgroundColor = .appBackgroundColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func updateInfo(viewModel: MovieMediaViewModel) {
        guard let viewModel = viewModel as? MediaImageViewModel else{ return }
        self.viewModel = viewModel
        if let imageURL = self.viewModel?.getImageURL(){
            self.updateInfo(imageURL: imageURL)
        }
    }
    
    private func updateInfo(imageURL: URL){
        let options = ImageLoadingOptions.init(placeholder: nil, transition: .fadeIn(duration: 0.17))
        Nuke.loadImage(with: imageURL, options: options, into: imgView, progress: nil, completion: nil)
    }
    
}
