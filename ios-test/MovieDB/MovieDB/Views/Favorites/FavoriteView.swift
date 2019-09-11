//
//  FavoriteView.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/10/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation
import UIKit

class FavoriteView: UIView {
    var tableView = UITableView()
    var cell_favorite_id = "cell_favorite_id"
    var controller: FavoritesController! {
        didSet {
            let buttonIcon = UIImage(named: "FilterIcon")
            let leftBarButton = UIBarButtonItem(title: "Filter", style: .done, target: self,
                                                action: #selector(filterActionButton))
            leftBarButton.image = buttonIcon
            controller.navigationItem.rightBarButtonItem = leftBarButton
        }
    }

    var dataSource: [MovieViewModel]! {
        didSet {
            if dataSource.count == 0 {
                removeFilterAction()
                displayState(message: "No favorites", icon: "heart_icon", visible: true)
            } else {
                displayState(message: "No favorites", icon: "heart_icon", visible: false)
                setupTableView()
            }
        }
    }

    let removeFilterButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = UIColor(red: 0.175, green: 0.191, blue: 0.277, alpha: 1.0)
        btn.setTitle("Remove Filter", for: .normal)
        btn.tintColor = UIColor(red: 0.967, green: 0.806, blue: 0.357, alpha: 1.0)
        btn.clipsToBounds = true
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(removeFilterAction), for: .touchUpInside)
        return btn
    }()

    let messageImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill // .scaleToFill
        image.image = UIImage(named: "search_icon")
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 6.0
        image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        return image
    }()

    let messageLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.font = UIFont.systemFont(ofSize: 24)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }

    func createSubviews() {
        backgroundColor = .white
    }

    func setupTableView() {
        // Define tableview cells on table
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: cell_favorite_id)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = frame
        tableView.tableFooterView = UIView()
        addSubview(tableView)
    }

    func displayState(message: String, icon: String, visible: Bool) {
        // Constrains
        addSubview(messageImage)
        addSubview(messageLabel)

        superview?.bringSubviewToFront(messageImage)
        superview?.bringSubviewToFront(messageLabel)

        if !visible {
            messageLabel.isHidden = true
            messageImage.isHidden = true
        } else {
            messageLabel.isHidden = false
            messageImage.isHidden = false
        }

        messageLabel.text = message // "Sua busca por \"x\" não resoulto em nenhum resultado."
        messageImage.image = UIImage(named: icon)

        let messageImageConstrains = [
            messageImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            messageImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageImage.heightAnchor.constraint(equalToConstant: 90),
            messageImage.widthAnchor.constraint(equalToConstant: 90)]
        NSLayoutConstraint.activate(messageImageConstrains)

        let messageLabelConstrains = [
            messageLabel.topAnchor.constraint(equalTo: messageImage.bottomAnchor, constant: 30),
            messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)]
        NSLayoutConstraint.activate(messageLabelConstrains)
    }
}

// MARK: - TableView DataSource, Delegate

extension FavoriteView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_favorite_id, for: indexPath) as! FavoriteCell
        let row = dataSource[indexPath.row]
        cell.viewModel = row
        return cell
    }
}

extension FavoriteView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if controller.viewModel.removeFavorite(viewModel: dataSource[indexPath.row]) {
                dataSource.remove(at: indexPath.row)
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.tableView.endUpdates()
            }
        }
    }
}

// MARK: - FilterSelectionDelegate

extension FavoriteView: FilterSelectionDelegate {
    @objc func filterActionButton(_ sender: UIBarButtonItem!) {
        let filterController = MovieFilterController()
        filterController.filterDelegate = self
        filterController.hidesBottomBarWhenPushed = true
        controller.navigationController?.pushViewController(filterController, animated: true)
    }

    @objc func removeFilterAction() {
        tableView.tableHeaderView = nil
    }

    func searchWithFilter(year: String, genre: String) {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(removeFilterButton)

        let headerViewConstrains = [
            headerView.widthAnchor.constraint(equalToConstant: frame.width),
            headerView.heightAnchor.constraint(equalToConstant: 50)]
        NSLayoutConstraint.activate(headerViewConstrains)

        let removeFilterButtonConstrains = [
            removeFilterButton.widthAnchor.constraint(equalToConstant: frame.width),
            removeFilterButton.heightAnchor.constraint(equalToConstant: 50)]
        NSLayoutConstraint.activate(removeFilterButtonConstrains)

        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = UIView()
        tableView.reloadData()
    }
}
