//
//  MoviesViewController.swift
//  Movies
//
//  Created by Pedro on 23-07-24.
//

import UIKit
import Combine
import Kingfisher

class MoviesViewController: UIViewController {
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelNoResults: UILabel!
    @IBOutlet weak var buttonRetry: UIButton!

    let searchController = UISearchController()
    let viewModel: MoviesViewModel
    var cancellables = Set<AnyCancellable>()
    let movieCellId = "cell"
    let footerCellId = "footer"
    weak var coordinator: MoviesCoordinator?
    private var isSearchActive: Bool {
        navigationItem.searchController?.isActive == true
    }

    init(viewModel: MoviesViewModel, moviesCoordinator: MoviesCoordinator) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        coordinator = moviesCoordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonRetry.accessibilityIdentifier = "retryButton"
        activityIndicator.accessibilityIdentifier = "activityIndicator"

        title = "Movies"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true

        moviesCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: movieCellId)
        moviesCollectionView.register(
            FooterActivityIndicatorView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId
        )
        moviesCollectionView.dataSource = self
        moviesCollectionView.delegate = self

        setupBindings()

        viewModel.getMovies()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateVisibleCells()
    }

    func updateVisibleCells() {
        for cell in moviesCollectionView.visibleCells {
            if let indexPath = moviesCollectionView.indexPath(for: cell),
               let movieCell = cell as? MovieCollectionViewCell,
               let movie = viewModel.filteredMovies[safe: indexPath.row] {
                viewModel.isFavorite(movie: movie) { [weak movieCell] in
                    movieCell?.bindFavoriteIcon(isFavorite: $0)
                }
            }
        }
    }

    func setupBindings() {
        viewModel
            .$uiState
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] uiState in
                guard let self else { return }
                buttonRetry.isHidden = true
                labelNoResults.isHidden = true
                activityIndicator.isHidden = true
                moviesCollectionView.isHidden = true
                switch uiState {
                case .idle:
                    break
                case .loading:
                    activityIndicator.isHidden = false
                case .error:
                    buttonRetry.isHidden = false
                case .success:
                    moviesCollectionView.isHidden = false
                }
            }.store(in: &cancellables)
        viewModel
            .$filteredMovies
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.moviesCollectionView.reloadData()
                self?.labelNoResults.isHidden = $0.isEmpty == false
            }.store(in: &cancellables)
    }

    @IBAction func buttonRetryTapped(_ sender: Any) {
        viewModel.getMovies()
    }
}

extension MoviesViewController: UICollectionViewDataSource,
                                    UICollectionViewDelegate,
                                    UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: movieCellId,
            for: indexPath
        ) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let movie = viewModel.filteredMovies[safe: indexPath.row],
           let url = MovieUrlProvider.to(movie) {
            cell.posterImageView.kf.setImage(with: url)
            cell.titleLabel.text = movie.title
            cell.toggleFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.delegate = self
            viewModel.isFavorite(movie: movie) { [weak cell] isFavorite in
                cell?.bindFavoriteIcon(isFavorite: isFavorite)
            }
        }
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width / 2
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = viewModel.filteredMovies[safe: indexPath.row] {
            coordinator?.showMovieDetail(movie: movie)
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.filteredMovies.count - 1 && !isSearchActive {
            viewModel.getMovies()
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        isSearchActive ? .zero : CGSize(width: collectionView.bounds.width, height: 50)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footerProgressIndicator = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: footerCellId, 
                for: indexPath) as? FooterActivityIndicatorView else {
            return UICollectionReusableView()
        }
        footerProgressIndicator.startAnimating()
        return footerProgressIndicator
    }
}

extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            return
        }
        viewModel.filterMovies(query: query)
    }
}

extension MoviesViewController: MovieCollectionViewCellDelegate {
    func toggleFavorite(for cell: MovieCollectionViewCell) {
        if let indexPath = moviesCollectionView.indexPath(for: cell),
           let movie = viewModel.filteredMovies[safe: indexPath.row] {
            viewModel.toggleFavorite(for: movie) { [weak cell] isFavorite in
                cell?.bindFavoriteIcon(isFavorite: isFavorite)
            }
        }
    }
}

@MainActor
class MoviesViewModel: ToggleFavorite {
    private let getMoviesUseCase: GetMoviesUseCase
    var addFavoriteUseCase: AddFavoriteUseCase
    var deleteFavoriteUseCase: DeleteFavoriteUseCase
    var isFavoriteMovieUseCase: IsFavoriteMovieUseCase
    var cancellables = Set<AnyCancellable>()

    private var movies = [Movie]()
    private var isLoadingNextPage = false
    private var page = 1
    @Published var filteredMovies = [Movie]()
    @Published var uiState: MovieUiState = .idle

    init(getMoviesUseCase: GetMoviesUseCase,
         addFavoriteUseCase: AddFavoriteUseCase,
         deleteFavoriteUseCase: DeleteFavoriteUseCase,
         isFavoriteMovieUseCase: IsFavoriteMovieUseCase) {
        self.getMoviesUseCase = getMoviesUseCase
        self.addFavoriteUseCase = addFavoriteUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
        self.isFavoriteMovieUseCase = isFavoriteMovieUseCase
    }

    func getMovies() {
        guard !isLoadingNextPage else {
            return
        }
        if movies.isEmpty {
            uiState = .loading
        }
        isLoadingNextPage = true
        getMoviesUseCase
            .execute(page: page)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print(failure)
                    if movies.isEmpty == true && page == 1 {
                        uiState = .error
                        isLoadingNextPage = false
                    } else { // Silent failure for infinite scroll
                        isLoadingNextPage = false
                    }
                }
            }, receiveValue: { [weak self] in
                self?.uiState = .success
                self?.movies.append(contentsOf: $0)
                self?.filteredMovies.append(contentsOf: $0)
                self?.page += 1
                self?.isLoadingNextPage = false
            }).store(in: &cancellables)
    }

    func filterMovies(query: String) {
        filteredMovies = query.isEmpty ? movies :
        movies.filter { $0.title.lowercased().contains(query.lowercased()) }
    }
}

enum MovieUiState {
    case idle, loading, error, success
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

class FooterActivityIndicatorView: UICollectionReusableView {
    let activityIndicator = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: topAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func startAnimating() {
        activityIndicator.startAnimating()
    }
}
