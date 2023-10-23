//
//  MovieViewModel.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 21-10-23.
//

import Foundation

class MovieViewModel: ObservableObject, MoviesDisplayLogic {
    
    @Published var displayedMovies: [Movies.FetchMovies.ViewModel.DisplayedMovie] = []
    private var allMovies: [Movies.FetchMovies.ViewModel.DisplayedMovie] = []
    @Published var errorMessage: String = ""
    @Published var showErrorAlert: Bool = false
    var interactor: MoviesBusinessLogic?
    var presenter: MoviesPresentationLogic?
    
    init() {
        let interactor = MoviesInteractor()
        let presenter = MoviesPresenter()
        self.interactor = interactor
        self.presenter = presenter
        interactor.presenter = presenter
        presenter.view = self
    }
    
    func fetchMovies() {
        let request = Movies.FetchMovies.Request()
        interactor?.fetchMovies(request: request)
    }
    
    func displayFetchedMovies(viewModel: Movies.FetchMovies.ViewModel) {
        allMovies = viewModel.displayedMovies
        displayedMovies = viewModel.displayedMovies
    }
    
    func displayError(message: String) {
        self.errorMessage = message
        self.showErrorAlert = true
    }
    
    func filterMovies(by searchText: String) {
        if !searchText.isEmpty {
            displayedMovies = allMovies.filter { movie in
                movie.title.lowercased().contains(searchText.lowercased())
            }
        } else {
            displayedMovies = allMovies
        }
    }
}
