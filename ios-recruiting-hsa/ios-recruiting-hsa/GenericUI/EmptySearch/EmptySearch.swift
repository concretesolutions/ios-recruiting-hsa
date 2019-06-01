//
//  EmptySearch.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/31/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

protocol Nibable {
    func setupNib()
}

extension Nibable where Self: UIView {

    private func loadNib() -> UIView? {
        let viewName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: viewName, bundle: nil)
        return nib.instantiate(withOwner: self, options: [:]).first as? UIView
    }

    func setupNib() {
        if let view = loadNib() {
            addSubview(view)
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}

class EmptySearch: UIView, Nibable {

    @IBOutlet private weak var descriptionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupNib()
    }

    func set(text: String) {
        descriptionLabel.text = text
    }

}
