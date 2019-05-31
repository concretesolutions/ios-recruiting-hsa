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
    var onFinishRetrieve: () -> Void { get set }
    var initialLoading: () -> Void { get set }

    var count: Int { get }
    func load()
    func fetchNextPage()
    func selectItem(atIndex index: IndexPath)
    func itemViewModel(at indexPath: IndexPath) -> MovieCollectionCellViewModel
}

class ListMovieViewModelImpl {

    // ListMovieViewModel Properties
    var onError: () -> Void = {}
    var onFinishRetrieve: () -> Void = {}
    var initialLoading: () -> Void = {}

    // Coordinator properties
    var onSelectedMovie: (PopularMovie) -> Void = { _ in }

    private let modelManager: ModelManager

    private var currentMovies: [PopularMovie]
    private var currentPage: Int

    init(modelManager: ModelManager) {
        self.modelManager = modelManager
        self.currentMovies = []
        self.currentPage = 0
    }
}

extension ListMovieViewModelImpl: ListMovieViewModel {

    var title: String { return "Movie" }

    var count: Int { return currentMovies.count }
    func load() {
        initialLoading()
        fetchNextPage()
    }

    func fetchNextPage() {
        modelManager.getPaginatedMovies(
            forPage: currentPage + 1,
            onSuccess: { [weak self] page, movies in
                self?.currentMovies.append(contentsOf: movies)
                self?.currentPage = page
                self?.onFinishRetrieve()
            },
            onError: { [weak self] _ in
                self?.onError()
            }
        )
    }

    func selectItem(atIndex index: IndexPath) {
        let movie = currentMovies[index.item]
        onSelectedMovie(movie)
    }

    func itemViewModel(at indexPath: IndexPath) -> MovieCollectionCellViewModel {
        let movie = currentMovies[indexPath.item]
        return MovieCollectionCellViewModelImpl(movie: movie)
    }
}
