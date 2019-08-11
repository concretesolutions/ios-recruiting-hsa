//
//  DetailPresenterImpl.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

class DetailPresenterImpl {
    weak var view: DetailView?
    private let movieUseCase: MovieUseCase
    private let movieDetailViewToModel: Mapper<MovieDetailView, MovieDetailModel>
    private let errorViewToModel: Mapper<ErrorView, ErrorModel>
    
    init(movieUseCase: MovieUseCase,
         movieDetailViewToModel: Mapper<MovieDetailView, MovieDetailModel>,
         errorViewToModel: Mapper<ErrorView, ErrorModel>
    ) {
        self.movieUseCase = movieUseCase
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
                } else {
                    self.view?.show(error: ErrorView(statusMessage: "Ups! Something went wrong!", statusCode: 0))
                }
                return
            }
            
            self.view?.show(detail: self.movieDetailViewToModel.reverseMap(value: movieDetailModel))
        }
    }
}
