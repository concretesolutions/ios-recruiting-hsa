//
//  GridPresenterImpl.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

class GridPresenterImpl {
    weak var view: GridView?
    private let movieUseCase: MovieUseCase
    private let movieViewToModel: Mapper<MovieView, MovieModel>
    private let errorViewToModel: Mapper<ErrorView, ErrorModel>
    private var popularPageNumber = 1
    
    init(movieUseCase: MovieUseCase,
         movieViewToModel: Mapper<MovieView, MovieModel>,
         errorViewToModel: Mapper<ErrorView, ErrorModel>
        ) {
        self.movieUseCase = movieUseCase
        self.movieViewToModel = movieViewToModel
        self.errorViewToModel = errorViewToModel
    }
}

extension GridPresenterImpl: GridPresenter {
    func attach(view: GridView) {
        self.view = view
        view.prepare()
    }
    
    func popularMovies() {
        view?.showLoading()
        movieUseCase.fetchMovies(page: popularPageNumber) { (movieModels, error) in
            self.view?.hideLoading()
            guard let movieModels = movieModels else {
                if let error = error {
                    self.view?.show(error: self.errorViewToModel.reverseMap(value: error))
                }
                return
            }
            
            if movieModels.count > 0 {
                self.view?.show(popular: self.movieViewToModel.reverseMap(values: movieModels))
                self.popularPageNumber += 1
            }
        }
    }
}
