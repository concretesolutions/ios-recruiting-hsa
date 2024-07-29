//
//  FavoritesViewController.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import UIKit
import Combine
import Kingfisher

class FavoritesViewController: UIViewController {
    let viewModel: FavoriteViewModel
    let cellId = "cell"
    weak var coordinator: FavoritesCoordinator?
    let searchController = UISearchController()
    var cancellables = Set<AnyCancellable>()
    var favoriteMoviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    var noResultsLabel: UILabel = {
        let label = UILabel()
        label.text = "No results"
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return label
    }()

    var buttonRemoveFilters: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Remove filters", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()

    init(viewModel: FavoriteViewModel, favoritesCoordinator: FavoritesCoordinator) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        coordinator = favoritesCoordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = UIView()
        view.backgroundColor = .systemBackground

        let stackView = UIStackView(arrangedSubviews: [
            buttonRemoveFilters,
            noResultsLabel
        ])
        stackView.backgroundColor = .systemBackground
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        let constraint = stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        constraint.priority = .defaultLow
        constraint.isActive = false

        view.addSubview(favoriteMoviesTableView)
        NSLayoutConstraint.activate([
            favoriteMoviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            favoriteMoviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            favoriteMoviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        favoriteMoviesTableView.topAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true

        buttonRemoveFilters.addTarget(
            self,
            action: #selector(removeFilters),
            for: .touchUpInside
        )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.isHidden = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        definesPresentationContext = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "pencil"),
            style: .plain,
            target: self,
            action: #selector(showFilters))

        favoriteMoviesTableView.register(FavoriteMovieTableViewCell.self, forCellReuseIdentifier: cellId)
        favoriteMoviesTableView.rowHeight = UITableView.automaticDimension
        favoriteMoviesTableView.dataSource = self
        favoriteMoviesTableView.delegate = self

        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getFavoriteMovies()
    }

    func setupBindings() {
        viewModel
            .$filteredMovies
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.favoriteMoviesTableView.reloadData()
                self?.noResultsLabel.isHidden = $0?.isEmpty == false
            }.store(in: &cancellables)
        viewModel
            .$hasActiveFilter
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.buttonRemoveFilters.isHidden = !$0
            }.store(in: &cancellables)
    }

    @objc
    func showFilters() {
        coordinator?.showFavoriteFilters(
            year: viewModel.yearFilter,
            genre: viewModel.genreFilter,
            delegate: self)
    }

    @objc
    func removeFilters() {
        viewModel.removeFilters()
    }
}

extension FavoritesViewController: FavouriteFiltersDelegate {
    func didEndPickingFilters(year: String?, genre: Genre?) {
        viewModel.setFilters(year: year, genre: genre)
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredMovies?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: cellId,
            for: indexPath
        ) as? FavoriteMovieTableViewCell else {
            return UITableViewCell()
        }
        if let movie = viewModel.filteredMovies?[safe: indexPath.row],
            let url = MovieUrlProvider.to(movie) {
            cell.posterImageView.kf.setImage(with: url)
            cell.titleLabel.text = movie.title
            cell.releaseYearLabel.text = viewModel.yearStringFrom(movie: movie)
            cell.overviewLabel.text = movie.overview
        }
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            if let movie = viewModel.filteredMovies?[safe: indexPath.row] {
                viewModel.deleteFavorite(movie: movie)
            }
        }
    }

    func tableView(
        _ tableView: UITableView,
        editingStyleForRowAt indexPath: IndexPath
    ) -> UITableViewCell.EditingStyle {
        .delete
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = viewModel.filteredMovies?[safe: indexPath.row] {
            coordinator?.showMovieDetail(movie: movie)
        }
    }
}

extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            return
        }
        viewModel.filterMovies(query: query)
    }
}

@MainActor
class FavoriteViewModel {
    private let getFavoritesUseCase: GetFavoritesUseCase
    private let deleteFavoriteUseCase: DeleteFavoriteUseCase
    private var cancellables = Set<AnyCancellable>()
    private var movies: [Movie]?

    @Published var filteredMovies: [Movie]?
    @Published var yearFilter: String?
    @Published var genreFilter: Genre?
    @Published var hasActiveFilter: Bool = false

    init(getFavoritesUseCase: GetFavoritesUseCase, deleteFavoriteUseCase: DeleteFavoriteUseCase) {
        self.getFavoritesUseCase = getFavoritesUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase

        $yearFilter
            .combineLatest($genreFilter)
            .receive(on: DispatchQueue.main)
            .map { year, genre in
                year != nil || genre != nil
            }.assign(to: &$hasActiveFilter)
    }

    func getFavoriteMovies() {
        getFavoritesUseCase
            .execute()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print(failure)
                }
            }, receiveValue: { [weak self] movies in
                self?.movies = movies
                self?.filteredMovies = movies

                if self?.hasActiveFilter == true {
                    self?.filterBy(year: self?.yearFilter, genre: self?.genreFilter)
                }
            }).store(in: &cancellables)
    }

    func deleteFavorite(movie: Movie) {
        deleteFavoriteUseCase
            .execute(movie: movie)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print(failure)
                }
            }, receiveValue: { [weak self] in
                print("Favorite movie deleted")
                if let index = self?.filteredMovies?.firstIndex(where: { $0.id == movie.id }) {
                    self?.filteredMovies?.remove(at: index)
                }
            }).store(in: &cancellables)
    }

    func filterMovies(query: String) {
        if hasActiveFilter {
            filterBy(year: yearFilter, genre: genreFilter)
        }
        let listForSearch = hasActiveFilter ? filteredMovies : movies
        filteredMovies = query.isEmpty ? listForSearch :
        listForSearch?.filter { $0.title.lowercased().contains(query.lowercased()) }
    }

    func removeFilters() {
        setFilters(year: nil, genre: nil)
        getFavoriteMovies()
    }

    func setFilters(year: String?, genre: Genre?) {
        yearFilter = year
        genreFilter = genre
    }

    func filterBy(year: String?, genre: Genre?) {
        if year == nil && genre == nil {
            filteredMovies = movies
            return
        }
        var filteredMovies = movies
        if let year {
            filteredMovies = filteredMovies?.filter {
                $0.releaseDate.contains(year)
            }
        }
        if let genre {
            filteredMovies = filteredMovies?.filter {
                $0.genreIds.contains(genre.id)
            }
        }
        self.filteredMovies = filteredMovies
    }

    func yearStringFrom(movie: Movie) -> String? {
        return MoviesDateParser.parseYearFrom(stringDate: movie.releaseDate)
    }
}
