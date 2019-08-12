//
//  FavoritepresenterImpl.swift
//  ios-recruiting-hsa
//
//  Created on 8/12/19.
//

class FavoritePresenterImpl {
    weak var view: FavoriteView?
    private let movieUseCase: MovieUseCase
    private let favoriteMovieViewToModel: Mapper<FavoriteMovieView, FavoriteMovieModel>
    private let errorViewToModel: Mapper<ErrorView, ErrorModel>
    
    init(movieUseCase: MovieUseCase,
         favoriteMovieViewToModel: Mapper<FavoriteMovieView, FavoriteMovieModel>,
         errorViewToModel: Mapper<ErrorView, ErrorModel>
    ) {
        self.movieUseCase = movieUseCase
        self.favoriteMovieViewToModel = favoriteMovieViewToModel
        self.errorViewToModel = errorViewToModel
    }
}

extension FavoritePresenterImpl: FavoritePresenter {
    func attach(view: FavoriteView) {
        self.view = view
        view.prepare()
    }
    
    func favoriteMovies() {
        view?.showLoading()
        movieUseCase.fetch { (movieModels, error) in
            self.view?.hideLoading()
            guard let movieModels = movieModels else {
                if let error = error {
                    self.view?.show(error: self.errorViewToModel.reverseMap(value: error))
                }
                return
            }
            
            self.view?.show(favorite: self.favoriteMovieViewToModel.reverseMap(values: movieModels))
        }
    }
    
    func deleteFavorite(movie: FavoriteMovieView) {
        view?.showLoading()
        movieUseCase.delete(movie: self.favoriteMovieViewToModel.map(value: movie)) { (error) in
            self.view?.hideLoading()
            guard let error = error else {
                self.view?.deleted()
                return
            }
            
            self.view?.show(error: self.errorViewToModel.reverseMap(value: error))
        }
    }
}
