//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Pedro on 25-07-24.
//

import UIKit
import Kingfisher
import Combine

class MovieDetailViewController: UIViewController {
    let contentScrollView = UIScrollView()
    var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 16/9).isActive = true
        return imageView
    }()
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    var genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    var releaseYearLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    var toggleFavoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .orange
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        return button
    }()
    var cancellables = Set<AnyCancellable>()

    let movie: Movie
    let getGenresByIdsUseCase: GetGenresByIdsUseCase
    let viewModel: MovieDetailViewModel

    init(movie: Movie,
         viewModel: MovieDetailViewModel,
         getGenresByIdsUseCase: GetGenresByIdsUseCase) {
        self.movie = movie
        self.viewModel = viewModel
        self.getGenresByIdsUseCase = getGenresByIdsUseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = UIView()
        view.backgroundColor = .systemBackground

        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentScrollView)
        NSLayoutConstraint.activate([
            contentScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let scrollableContentView = UIView()
        scrollableContentView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.addSubview(scrollableContentView)

        NSLayoutConstraint.activate([
            scrollableContentView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            scrollableContentView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            scrollableContentView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor)
        ])

        let bottomConstraint = scrollableContentView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor)
        bottomConstraint.priority = .defaultHigh
        bottomConstraint.isActive = true
        scrollableContentView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        toggleFavoriteButton.addTarget(
            self,
            action: #selector(toggleFavoriteButtonTapped),
            for: .touchUpInside
        )

        let contentStackView = UIStackView()
        contentStackView.axis = .vertical
        contentStackView.spacing = 10
        let margin = 10.0
        contentStackView.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        contentStackView.isLayoutMarginsRelativeArrangement = true
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.addArrangedSubview(posterImageView)

        let detailStack = UIStackView(arrangedSubviews: [
            titleLabel,
            toggleFavoriteButton
        ])
        detailStack.axis = .horizontal

        contentStackView.addArrangedSubview(detailStack)
        contentStackView.addArrangedSubview(releaseYearLabel)
        contentStackView.addArrangedSubview(genresLabel)
        contentStackView.addArrangedSubview(overviewLabel)
        scrollableContentView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: scrollableContentView.leadingAnchor),
            contentStackView.topAnchor.constraint(equalTo: scrollableContentView.topAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: scrollableContentView.trailingAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollableContentView.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind(movie: movie)
    }

    func bind(movie: Movie) {
        if let url = MovieUrlProvider.to(movie) {
            posterImageView.kf.setImage(with: url)
        }
        titleLabel.text = movie.title
        releaseYearLabel.text = viewModel.yearStringFrom(movie: movie)
        overviewLabel.text = movie.overview
        viewModel.isFavorite(movie: movie) { [weak self] isFavorite in
            self?.bindFavoriteIcon(isFavorite: isFavorite)
        }
        getGenresByIdsUseCase
            .execute(ids: movie.genreIds)
            .receive(on: DispatchQueue.main)
            .replaceError(with: [])
            .sink { [weak self] in
                let genres = $0.reduce("", { result, genre in
                    result + "\(genre.name), "
                }).dropLast(2)
                self?.genresLabel.text = String(genres)
            }.store(in: &cancellables)
    }

    @objc
    func toggleFavoriteButtonTapped() {
        viewModel.toggleFavorite(for: movie) { [weak self] isFavorite in
            self?.bindFavoriteIcon(isFavorite: isFavorite)
        }
    }

    func bindFavoriteIcon(isFavorite: Bool) {
        toggleFavoriteButton.setImage(
            UIImage(systemName: isFavorite ? "heart.fill" : "heart"),
            for: .normal
        )
    }
}

@MainActor
class MovieDetailViewModel: ToggleFavorite {
    var addFavoriteUseCase: AddFavoriteUseCase
    var deleteFavoriteUseCase: DeleteFavoriteUseCase
    var isFavoriteMovieUseCase: IsFavoriteMovieUseCase
    var cancellables = Set<AnyCancellable>()

    init(addFavoriteUseCase: AddFavoriteUseCase,
         deleteFavoriteUseCase: DeleteFavoriteUseCase,
         isFavoriteMovieUseCase: IsFavoriteMovieUseCase) {
        self.addFavoriteUseCase = addFavoriteUseCase
        self.deleteFavoriteUseCase = deleteFavoriteUseCase
        self.isFavoriteMovieUseCase = isFavoriteMovieUseCase
    }
}

@MainActor
protocol ToggleFavorite: AnyObject {
    var addFavoriteUseCase: AddFavoriteUseCase { get }
    var deleteFavoriteUseCase: DeleteFavoriteUseCase { get }
    var isFavoriteMovieUseCase: IsFavoriteMovieUseCase { get }
    var cancellables: Set<AnyCancellable> { get set }
}

extension ToggleFavorite {
    func isFavorite(movie: Movie, completion: @escaping (Bool) -> Void) {
        isFavoriteMovieUseCase
            .execute(movie: movie)
            .replaceError(with: false)
            .map { $0 }
            .sink {
                completion($0)
            }.store(in: &cancellables)
    }

    func toggleFavorite(for movie: Movie, completion: @escaping (Bool) -> Void) {
        var newValue = false
        isFavoriteMovieUseCase
            .execute(movie: movie)
            .flatMap { [deleteFavoriteUseCase, addFavoriteUseCase] isFavorite in
                newValue = !isFavorite
                return isFavorite ?
                deleteFavoriteUseCase.execute(
                    movie: movie
                ) : addFavoriteUseCase.execute(
                    movie: movie
                )
            }.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let failure):
                    print(failure)
                }
            }, receiveValue: {
                completion(newValue)
            }).store(in: &cancellables)
    }

    func yearStringFrom(movie: Movie) -> String? {
        return MoviesDateParser.parseYearFrom(stringDate: movie.releaseDate)
    }
}
