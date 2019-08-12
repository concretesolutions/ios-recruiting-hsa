//
//  DetailPresenterImpl.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

class DetailPresenterImpl {
    weak var view: DetailView?
    private let movieUseCase: MovieUseCase
    private let movieDetailViewToFavoriteMovieModel: Mapper<MovieDetailView, FavoriteMovieModel>
    private let movieDetailViewToModel: Mapper<MovieDetailView, MovieDetailModel>
    private let errorViewToModel: Mapper<ErrorView, ErrorModel>
    
    init(movieUseCase: MovieUseCase,
         movieDetailViewToFavoriteMovieModel: Mapper<MovieDetailView, FavoriteMovieModel>,
         movieDetailViewToModel: Mapper<MovieDetailView, MovieDetailModel>,
         errorViewToModel: Mapper<ErrorView, ErrorModel>
    ) {
        self.movieUseCase = movieUseCase
        self.movieDetailViewToFavoriteMovieModel = movieDetailViewToFavoriteMovieModel
        self.movieDetailViewToModel = movieDetailViewToModel
        self.errorViewToModel = errorViewToModel
    }
}

extension DetailPresenterImpl: DetailPresenter {
    func attach(view: DetailView) {
        self.view = view
        view.prepare()
    }
    
    func movieDetail(id: Int) {
        view?.showLoading()
        movieUseCase.fetchMovieDetail(id: id) { (movieDetailModel, error) in
            self.view?.hideLoading()
            guard let movieDetailModel = movieDetailModel else {
                if let error = error {
                    self.view?.show(error: self.errorViewToModel.reverseMap(value: error))
                }
                return
            }
            
            self.view?.show(detail: self.movieDetailViewToModel.reverseMap(value: movieDetailModel))
        }
    }
    
    func addFavorite(movie: MovieDetailView) {
        view?.showLoading()
        
        self.movieUseCase.fetch(movieId: movie.id, completionHandler: { (favoriteMovie, error) in
            if let favoriteMovie = favoriteMovie, favoriteMovie.id == movie.id {
                return
            }
            
            self.movieUseCase.save(movie: self.movieDetailViewToFavoriteMovieModel.map(value: movie)) { (error) in
                guard let error = error else {
                    self.view?.markFavorite()
                    return
                }
                
                self.view?.show(error: self.errorViewToModel.reverseMap(value: error))
            }
        })
        self.view?.hideLoading()
    }
    
    func isFavorite(movieId: Int) {
        self.movieUseCase.fetch(movieId: movieId, completionHandler: { (favoriteMovie, error) in
            if let favoriteMovie = favoriteMovie, favoriteMovie.id == movieId {
                self.view?.markFavorite()
            }
        })
    }
}
