//
//  MovieTemplateView.swift
//  recruiting
//
//  Created by Diego Vargas on 4/21/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation
import UIKit

class MovieTemplateView: BaseTemplateView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var actionButtonHeight: NSLayoutConstraint!
    
    override func updateUI() {
        super.updateUI()
        if let card = self.data as? CardTemplate {
            self.titleLabel.text = card.title
            self.subtitleLabel.text = card.subtitle
            self.actionButton.setTitle("Ver ficha de \(card.title)", for: UIControl.State.normal)
        }
        self.actionButtonHeight.constant = 50
    }
    
    @IBAction func runAction() {
        self.handler?.run()
    }
}
