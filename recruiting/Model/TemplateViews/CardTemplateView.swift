//
//  CardTemplateView.swift
//  recruiting
//
//  Created by Diego Vargas on 4/20/19.
//  Copyright © 2019 concrete. All rights reserved.
//

import Foundation
import UIKit

class CardTemplateView: BaseTemplateView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var actionButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func updateUI() {
        super.updateUI()
        if let card = self.data as? CardTemplate {
            self.titleLabel.text = card.title
            self.textView.text = card.subtitle
            self.imageView.downloaded(from: "https://image.tmdb.org/t/p/w370_and_h556_bestv2/\(card.poster_path)")
            self.actionButton.setTitle("Ver ficha de \(card.title)", for: UIControl.State.normal)
        }
        self.actionButtonHeight.constant = 50
    }
    
    @IBAction func runAction() {
        self.handler?.run()
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
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
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
