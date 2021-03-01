//
//  MovieListVC.swift
//  MovieApp
//
//  Created by Hector Morales on 2/27/21.
//

import UIKit

class MovieListVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var noItemsLabel: UILabel!
    private let refreshControl = UIRefreshControl()
    var page: Int = 1
    var presenter: MovieListPresenter?
    lazy var filteredItemsArray: [Movie] = []
    lazy var items: [Movie] = []
    lazy var isLastPageReach: Bool = false
    lazy var inSearchMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieListPresenter(dataSource: self)
        setCollectionView()
        setupSeacher()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateMoviesArrays),
                                               name: NotificationNames.updateMoviesInList,
                                               object: nil)
    }

    @objc func updateMoviesArrays(){
        guard let presenter = presenter else { return }
        items = presenter.refreshingFavorites(movies: items)
        filteredItemsArray = presenter.refreshingFavorites(movies: filteredItemsArray)
        collectionView.reloadData()
    }


    func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.nib,
                                     forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.refreshControl = refreshControl
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
    }

    @objc private func refreshTableView() {
        noItemsLabel.isHidden = true
        page = 1
        inSearchMode = false
        isLastPageReach = false
        refreshControl.endRefreshing()
        searchTextField.text = nil
        presenter?.getMovies(page: page)
    }

    func setupSeacher(){
        searchTextField.returnKeyType = .done
        searchTextField.addTarget(self,
                                  action: #selector(self.textFieldDidChange(_:)),
                                  for: UIControl.Event.editingChanged)
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Buscar..",
                                                                   attributes: [NSAttributedString.Key.foregroundColor:
                                                                                    UIColor.white])
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            inSearchMode = false
            collectionView.reloadData()
        } else {
            inSearchMode = true
            let lower = searchTextField.text!.lowercased()
            filteredItemsArray = items.filter({
                $0.title?
                    .folding(options: .diacriticInsensitive, locale: .current)
                    .lowercased()
                    .contains(lower) ?? false
            })
            collectionView.reloadData()
        }
    }

    private func updateMessageNoFoundLabel(){
        noItemsLabel.text = inSearchMode ? "No se encontraron coincidencias." : "Ocurrió un error al intentar conectar con el servidor, por favor intenta de nuevo."
        noItemsLabel.isHidden = inSearchMode ? !filteredItemsArray.isEmpty : !items.isEmpty
    }

}

extension MovieListVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        updateMessageNoFoundLabel()
        return inSearchMode ? filteredItemsArray.count : items.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                            for: indexPath) as! MovieCollectionViewCell
        let movie = inSearchMode ? filteredItemsArray[indexPath.row] : items[indexPath.row]

        cell.setup(movie: movie)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2, height: collectionView.bounds.height / 1.8)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = inSearchMode ? filteredItemsArray[indexPath.row] : items[indexPath.row]
        let vc = DetailMovieVC(movie: movie)
        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if index == (items.count - 1), !isLastPageReach, !inSearchMode {
            page +=  1
            presenter?.getMovies(page: page)
        }
    }

}

extension MovieListVC: MovieListPresenterProtocol {
    func gotMovies(items: [Movie], currentPage: Int) {
        if page == 1 { self.items = items }
        else { self.items += items }
        if items.count == 0 { isLastPageReach = true }
        noItemsLabel.isHidden = !self.items.isEmpty
        collectionView.reloadData()
    }

    func gotError() {
        items.removeAll()
        filteredItemsArray.removeAll()
        collectionView.reloadData()
        noItemsLabel.isHidden = !self.items.isEmpty
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }

}
