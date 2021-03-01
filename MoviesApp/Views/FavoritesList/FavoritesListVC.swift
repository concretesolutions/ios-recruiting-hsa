//
//  FavoritesListVC.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/28/21.
//

import UIKit

class FavoritesListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var noItemsLabel: UILabel!
    lazy var favoritesArray: [Movie] = []
    lazy var filteredFavoritesArray: [Movie] = []
    lazy var inSearchMode = false
    var presenter: FavoritesListPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritesListPresenter(dataSource: self)
        setupTableView()
        setupSeacher()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadFavorites()
    }

    private func loadFavorites(){
        noItemsLabel.isHidden = true
        presenter?.loadFavorites()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
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
            tableView.reloadData()
        } else {
            inSearchMode = true
            let lower = searchTextField.text!.lowercased()
            filteredFavoritesArray = favoritesArray.filter({
                $0.title?
                    .folding(options: .diacriticInsensitive, locale: .current)
                    .lowercased()
                    .contains(lower) ?? false
            })
            tableView.reloadData()
        }
    }

    private func updateMessageNoFoundLabel(){
        noItemsLabel.isHidden = inSearchMode ? !filteredFavoritesArray.isEmpty : !favoritesArray.isEmpty
        noItemsLabel.text = inSearchMode ? "No se encontraron coincidencias." : "No tienes favoritos registrados"
    }

}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        updateMessageNoFoundLabel()
        return inSearchMode ? filteredFavoritesArray.count : favoritesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as? MovieTableViewCell
        else { return UITableViewCell()}
        let movie = inSearchMode ? filteredFavoritesArray[indexPath.row] : favoritesArray[indexPath.row]
        cell.setup(movie: movie)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MovieTableViewCell.height
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Eliminar") { [weak self] (contextualAction, view, boolValue) in
            guard let strongSelf = self else { return }
            let movie = strongSelf.inSearchMode ? strongSelf.filteredFavoritesArray[indexPath.row] : strongSelf.favoritesArray[indexPath.row]
            strongSelf.presenter?.deleteMovieFromFavorites(movie: movie)
            strongSelf.loadFavorites()
            strongSelf.tableView.reloadData()
            NotificationCenter.default.post(name: Notification.Name("updateMoviesInList"),
                                            object: nil,
                                            userInfo: nil)
        }
        contextItem.backgroundColor = .darkGray
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        return swipeActions
  }

}

extension FavoritesListVC: FavoritesListPresenterProtocol {
    
    func loadMoviesFavorites(items: [Movie]) {
        self.favoritesArray = items
        textFieldDidChange(searchTextField)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func gotDeleteMovieSuccessfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

}
