//
//  MovieView.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/10/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation
import UIKit

class MovieView: UIView, UISearchResultsUpdating {

    var controller: MoviesController!
    var collectionview: UICollectionView!
    var movie_cell = "movie_cell"
    var indicator = UIActivityIndicatorView()
    var searchController = UISearchController(searchResultsController: nil)
    var dataSourceFiltered = [MovieViewModel]()
    var dataSource: [MovieViewModel]! {
        didSet {
            setupSearchController()
            setupCollectionView()
        }
    }

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
        setupCollectionView()
    }

    func setupCollectionView() {

        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)

        collectionview = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(MovieCell.self, forCellWithReuseIdentifier: movie_cell)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1.0)
        addSubview(collectionview)
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

    func setupSearchController() {
        searchController.searchBar.sizeToFit()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.dimsBackgroundDuringPresentation = false
    }

    func searchBarIsEmpty() -> Bool {
        if searchController.isActive && searchController.searchBar.text != "" {
            return true
        } else {
            return false
        }
    }

    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text {
            filterRowsForSearchedText(term)
        }
    }

    func filterRowsForSearchedText(_ searchText: String) {

        dataSourceFiltered = dataSource.filter({ (model: MovieViewModel) -> Bool in
            model.originalTitle.lowercased().contains(searchText.lowercased())
        })

        if dataSourceFiltered.count == 0 && searchText.count > 0 {
            displayState(message: "Search Term \"\(searchText.lowercased())\" could not be found.", icon: "search_icon", visible: true)
            collectionview.reloadData()
        } else {
            displayState(message: "Search Term \"\(searchText.lowercased())\" could not be found.", icon: "search_icon", visible: false)
            collectionview.reloadData()
        }
    }

    func startSpinner() {

        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = UIActivityIndicatorView.Style.gray
        indicator.translatesAutoresizingMaskIntoConstraints = false

        DispatchQueue.main.async {
            self.addSubview(self.indicator)
            self.indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            self.indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        }
        indicator.startAnimating()
        indicator.backgroundColor = UIColor.clear
    }

    func stopSpinner() {
        indicator.stopAnimating()
        indicator.hidesWhenStopped = true
    }
}

// MARK: - CollectionView

extension MovieView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchBarIsEmpty() {
            return dataSourceFiltered.count
        }
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 50
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: 250)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: movie_cell, for: indexPath) as! MovieCell

        if searchBarIsEmpty() {
            let movieRow = dataSourceFiltered[indexPath.row]
            cell.viewModel = movieRow
            return cell
        }

        let movieRow = dataSource[indexPath.row]
        cell.viewModel = movieRow
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchBarIsEmpty() {
            let movieRow = dataSourceFiltered[indexPath.row]
            let detailController = MovieDetailController()
            detailController.movieViewModel = movieRow
            controller.navigationController?.pushViewController(detailController, animated: true)
        } else {
            let movieRow = dataSource[indexPath.row]
            let detailController = MovieDetailController()
            detailController.movieViewModel = movieRow
            controller.navigationController?.pushViewController(detailController, animated: true)
        }
    }
}
