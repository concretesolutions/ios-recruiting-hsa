//
//  MovieMediaVideoTableViewCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/8/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit
import Nuke

class MovieMediaVideoTableViewCell: UITableViewCell, MovieMediaConfigurableCell, MediaVideoViewModelDelegate {

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var playerBt: UIButton!
    
    var viewModel: MediaVideoViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .appBackgroundColor
        imgView.backgroundColor = .appBackgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func updateInfo(viewModel: MovieMediaViewModel) {
        guard let viewModel = viewModel as? MediaVideoViewModel else { return }
        self.viewModel = viewModel
        self.viewModel?.delegate = self
        titleLb.text = viewModel.videoName
        playerBt.setTitle("Ver en \(viewModel.originSite)", for: .normal)
        
        if let url = viewModel.getThumbnailURL(){
            loadImage(fromURL: url)
        }
    }
    
    func loadImage(fromURL: URL){
        let options = ImageLoadingOptions.init(placeholder: nil, transition: .fadeIn(duration: 0.17))
        Nuke.loadImage(with: fromURL, options: options, into: imgView, progress: nil, completion: nil)
    }
    
    //Los videos se abren desde aqui para que el viewmodel no haga import de UIKit
    func openExternalVideo(deepLinkStr: String, webURLStr: String){
     
        if let deepLinkURL = URL(string: deepLinkStr),
            UIApplication.shared.canOpenURL(deepLinkURL) {
            
            UIApplication.shared.open(deepLinkURL, options: [:], completionHandler: nil)
            
        } else if let webURL = URL(string:webURLStr) {
            
            UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
        }
        
    }
    
    @IBAction func openPlayerAction(_ sender: Any) {
        viewModel?.openVideo()
    }
}
