//
//  MovieDetailViewModel.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/5/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

// Ejemplo de comunicación con delegate entre el viewModel y el viewcontroller.
protocol MovieDetailDelegate: class {
    func onLoadingStatus(isLoading: Bool)
    func onDataUpdate(movie: MovieDetailModel)
    func onMediaUpdate(movieMedia:MovieMediaModel)
    func onErrorHandler(error: Error)
}

class MovieDetailViewModel{
    
    weak var coordinator: MovieDetailCoordinator?
    weak var delegate: MovieDetailDelegate?
    
    let movieId: Int
    var currentMovie: MovieDetailModel?
    var movieMedia = MovieMediaModel()
    
    
    init(movieId: Int, coordinator: MovieDetailCoordinator) {
        self.coordinator = coordinator
        self.movieId = movieId
    }
    
    func fetchMovieData(){
        let networkRouter = MovieDetailRouter.getDetail(movieId: movieId)
        let router = MovieDetailQueryRouter.init(networkRouter: networkRouter)
        delegate?.onLoadingStatus(isLoading: true)
        DataProvider.requestForData(router: router) { (result: Result<MovieDetailModel, Error>) in
            self.delegate?.onLoadingStatus(isLoading: false)
            switch result{
            case .success(let movie):
                self.currentMovie = movie
                self.fetchMovieVideos()
                self.delegate?.onDataUpdate(movie: movie)
                break
            case .failure(let error):
                self.delegate?.onErrorHandler(error: error)
                break
            }
        }
    }
    
    func fetchMovieImages(){
        let networkRouter = MovieDetailRouter.getImages(movieId: movieId)
        let router = MovieDetailQueryRouter.init(networkRouter: networkRouter)
        DataProvider.requestForData(router: router) { (result: Result<MovieImagesModel, Error>) in
            switch result{
            case .success(let movieImage):
                self.movieMedia.movieImages = movieImage
                self.delegate?.onMediaUpdate(movieMedia: self.movieMedia)
                break
            case .failure(let error):
                self.delegate?.onErrorHandler(error: error)
                break
            }
        }
    }
    
    func fetchMovieVideos(){
        let networkRouter = MovieDetailRouter.getVideos(movieId: movieId)
        let router = MovieDetailQueryRouter.init(networkRouter: networkRouter)
        DataProvider.requestForData(router: router) { (result: Result<MovieVideoModel, Error>) in
            switch result{
            case .success(let movieVideo):
                self.movieMedia.movieVideos = movieVideo
                self.fetchMovieImages()
                break
            case .failure(let error):
                self.delegate?.onErrorHandler(error: error)
                break
            }
        }
    }
    
    
    func getTableViewDataSource(forSelectedIndex: Int)->MovieDetailTableViewDataSource?{
        guard let movie = currentMovie else{
            return nil
        }
      
        switch forSelectedIndex {
       
        case 0:
            return MovieDetailFeaturesDataSource.init(movie: movie)
        case 1:
            return MovieDetailMediaDataSource.init(movieMedia: self.movieMedia)
        default:
            return MovieDetailFeaturesDataSource.init(movie: movie)
      
        }
    }
    
}
