//
//  CustomSearchBar.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/28/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation
import UIKit

class CustomSearchBar: UIView {

    private var containerSearchView: UIView!
    private var filterSearch: UITextField!
    private let verticalInset: CGFloat = 3
    private let horizontalInset: CGFloat = 10

    var searchBackgroundColor: UIColor? = .white {
        didSet {
            updateFilterFillColor(with: searchBackgroundColor)
        }
    }

    var placeholder: String = ""

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)

        setContainerView()
        setSearchView()

        updateFilterFillColor(with: searchBackgroundColor)
    }

    private func setContainerView() {
        containerSearchView = UIView()
        containerSearchView.layer.cornerRadius = 5
        addSubview(containerSearchView)
        containerSearchView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = containerSearchView.topAnchor.constraint(
            equalTo: topAnchor,
            constant: verticalInset
        )
        let bottomConstraint = bottomAnchor.constraint(
            equalTo: containerSearchView.bottomAnchor,
            constant: verticalInset
        )
        let leadingConstraint = containerSearchView.leadingAnchor.constraint(
            equalTo: leadingAnchor,
            constant: horizontalInset
        )
        let trailingGonstraint = trailingAnchor.constraint(
            equalTo: containerSearchView.trailingAnchor,
            constant: horizontalInset
        )
        topConstraint.isActive = true
        bottomConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingGonstraint.isActive = true
    }

    private func setSearchView() {
        filterSearch = UITextField()
        filterSearch.isUserInteractionEnabled = false
        addSubview(filterSearch)
        filterSearch.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = filterSearch.topAnchor.constraint(
            equalTo: containerSearchView.topAnchor
        )
        let bottomConstraint = containerSearchView.bottomAnchor.constraint(
            equalTo: filterSearch.bottomAnchor
        )
        let leadingConstraint = filterSearch.leadingAnchor.constraint(
            equalTo: containerSearchView.leadingAnchor,
            constant: 5
        )
        let trailingConstraint = containerSearchView.trailingAnchor.constraint(
            equalTo: filterSearch.trailingAnchor,
            constant: 5
        )
        topConstraint.isActive = true
        bottomConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true

        filterSearch.delegate = self
    }

    private func updateFilterFillColor(with color: UIColor?) {
        filterSearch.backgroundColor = color
        containerSearchView.backgroundColor = color
    }

    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        filterSearch.isUserInteractionEnabled = true
        filterSearch.becomeFirstResponder()
    }

    // MARK: - Public overrides

    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return filterSearch.resignFirstResponder()
    }
}

extension CustomSearchBar: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1) { self.updateFilterFillColor(with: .white) }
    }

}
