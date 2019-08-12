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
    
    func save(movie: FavoriteMovieModel, completionHandler: @escaping (ErrorModel?) -> Void) {
        movieRepository.save(movie: movie) { (error) in
            completionHandler(error)
        }
    }
    
    func fetch(completionHandler: @escaping ([FavoriteMovieModel]?, ErrorModel?) -> Void) {
        movieRepository.fetch { (movies, error) in
            completionHandler(movies, error)
        }
    }
    
    func fetch(movieId: Int, completionHandler: @escaping (FavoriteMovieModel?, ErrorModel?) -> Void) {
        movieRepository.fetch(movieId: movieId) { (movie, error) in
            completionHandler(movie, error)
        }
    }
    
    func delete(movie: FavoriteMovieModel, completionHandler: @escaping (ErrorModel?) -> Void) {
        movieRepository.delete(movie: movie) { (error) in
            completionHandler(error)
        }
    }
}
