//
//  MovieUseCase.swift
//  ios-recruiting-hsa
//
//  Created on 8/8/19.
//

class MovieUseCase {
    private let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func fetchMovies(page: Int, completionHandler: @escaping ([MovieModel]?, ErrorModel?) -> Void) {
        movieRepository.fetchMovies(page: page) { (movieResponse, error) in
            completionHandler(movieResponse?.results, error)
        }
    }
    
    func fetchMovieDetail(id: Int, completionHandler: @escaping (MovieDetailModel?, ErrorModel?) -> Void) {
        movieRepository.fetchMovieDetail(id: id) { (movieDetail, error) in
            completionHandler(movieDetail, error)
        }
    }
}
