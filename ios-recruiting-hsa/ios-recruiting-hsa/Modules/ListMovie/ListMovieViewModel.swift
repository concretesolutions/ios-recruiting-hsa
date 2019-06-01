//
//  ListMovieViewModel.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/30/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

protocol ListMovieViewModel {
    var title: String { get }

    var onError: () -> Void { get set }
    var onUpdate: () -> Void { get set }
    var startLoading: () -> Void { get set }
    var stopLoading: () -> Void { get set }

    var count: Int { get }
    var filterTextEmptySearch: String { get }
    func load()
    func fetchNextPage()
    func selectItem(atIndex index: IndexPath)
    func itemViewModel(at indexPath: IndexPath) -> MovieCollectionCellViewModel
    func setCurrent(filterText text: String)
}

class ListMovieViewModelImpl {

    // ListMovieViewModel Properties
    var onError: () -> Void = {}
    var onUpdate: () -> Void = {}
    var startLoading: () -> Void = {}
    var stopLoading: () -> Void = {}

    // Coordinator properties
    var onSelectedMovie: (PopularMovie) -> Void = { _ in }

    private let favoritesManager: FavoritesManager
    private let modelManager: ModelManager

    private var currentMovies: [PopularMovie]
    private var filteredMovies: [PopularMovie]
    private var filterText: String
    private var currentPage: Int

    init(modelManager: ModelManager, favoritesManager: FavoritesManager) {
        self.modelManager = modelManager
        self.favoritesManager = favoritesManager
        self.currentMovies = []
        self.filteredMovies = []
        self.currentPage = 0
        self.filterText = ""
    }
}

extension ListMovieViewModelImpl: ListMovieViewModel {

    var title: String { return "Movie" }

    var count: Int { return filteredMovies.count }

    var filterTextEmptySearch: String {
        return #"Su búsqueda por "\#(filterText)" no ha resultado en ningún resultado"#
    }

    func load() {
        fetchNextPage()
    }

    func fetchNextPage() {
        startLoading()
        modelManager.getPaginatedMovies(
            forPage: currentPage + 1,
            onSuccess: { [weak self] page, movies in
                guard let self = self else { return }
                let filteredMovies = self.filterMovies(text: self.filterText, movies: movies)
                self.currentMovies.append(contentsOf: movies)
                self.filteredMovies.append(contentsOf: filteredMovies)
                self.currentPage = page
                self.stopLoading()
                self.onUpdate()
            },
            onError: { [weak self] _ in
                self?.stopLoading()
                self?.onError()
            }
        )
    }

    private func filterMovies(text: String, movies: [PopularMovie]) -> [PopularMovie] {
        let filteredMovies: [PopularMovie]
        if text != "" {
            filteredMovies = movies.filter {
                $0.title?.lowercased().contains(text) ?? false
            }
        } else {
            filteredMovies = movies
        }
        return filteredMovies
    }

    func selectItem(atIndex index: IndexPath) {
        let movie = filteredMovies[index.item]
        onSelectedMovie(movie)
    }

    func itemViewModel(at indexPath: IndexPath) -> MovieCollectionCellViewModel {
        let movie = filteredMovies[indexPath.item]
        return MovieCollectionCellViewModelImpl(movie: movie, favoritesManager: favoritesManager)
    }

    func setCurrent(filterText text: String) {
        // This filter could be send to background and executes the `onUpdate` in main for
        // performance
        filterText = text.lowercased()
        filteredMovies = filterMovies(text: filterText, movies: currentMovies)
        onUpdate()
    }
}
