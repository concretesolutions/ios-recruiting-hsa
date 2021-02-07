//
//  FilterTableViewCell.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    
    @IBOutlet weak var contentValueNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Variables
    
    weak var filter: Filter<String>? {
        didSet {
            guard let value = filter else { return }
            self.nameLabel.text = value.name
            self.contentValueNameLabel.text = value.value
        }
    }
    
    //MARK: - Awake from Nib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
