//
//  TitleFavoriteCell.swift
//  Movs
//
//  Created by Miguel Duran on 1/7/19.
//  Copyright © 2019 Miguel Duran. All rights reserved.
//

import UIKit

protocol TitleFavoriteCellDelegate: AnyObject {
    func titleFavoriteCell(_ cell: TitleFavoriteCell)
}

class TitleFavoriteCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    weak var delegate: TitleFavoriteCellDelegate?
    
    var viewModel = ViewModel() {
        didSet {
            titleLabel.text = viewModel.title
            favoriteButton.isSelected = viewModel.isFavorite
        }
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        delegate?.titleFavoriteCell(self)
    }
}

extension TitleFavoriteCell {
    struct ViewModel {
        var title = ""
        var isFavorite = false
    }
}
