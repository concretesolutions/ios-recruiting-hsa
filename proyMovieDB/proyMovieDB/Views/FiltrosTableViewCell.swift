//
//  FiltrosTableViewCell.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 11-06-23.
//

import UIKit

class FiltrosTableViewCell: UITableViewCell {

    @IBOutlet weak var tipoFiltro: UILabel!
    @IBOutlet weak var valorFiltro: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
