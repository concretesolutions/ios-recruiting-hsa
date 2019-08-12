//
//  MovieRepositoryImpl.swift
//  ios-recruiting-hsa
//
//  Created on 07-08-19.
//

class MovieRepositoryImpl: MovieRepository {
    private let movieRestApi: MovieRestApi
    private let movieLocalData: MovieLocalData
    private let favoriteMovieModelToEntity: Mapper<FavoriteMovieModel, FavoriteMovieEntity>
    private let movieResponseModelToEntity: Mapper<MovieResponseModel, MovieResponseEntity>
    private let movieDetailModelToEntity: Mapper<MovieDetailModel, MovieDetailEntity>
    private let errorModelToEntity: Mapper<ErrorModel, ErrorEntity>
    
    init(movieRestApi: MovieRestApi,
         movieLocalData: MovieLocalData,
         favoriteMovieModelToEntity: Mapper<FavoriteMovieModel, FavoriteMovieEntity>,
         movieResponseModelToEntity: Mapper<MovieResponseModel, MovieResponseEntity>,
         movieDetailModelToEntity: Mapper<MovieDetailModel, MovieDetailEntity>,
         errorModelToEntity: Mapper<ErrorModel, ErrorEntity>
    ) {
        self.movieRestApi = movieRestApi
        self.movieLocalData = movieLocalData
        self.favoriteMovieModelToEntity = favoriteMovieModelToEntity
        self.movieResponseModelToEntity = movieResponseModelToEntity
        self.movieDetailModelToEntity = movieDetailModelToEntity
        self.errorModelToEntity = errorModelToEntity
    }
    
    func fetchMovies(page: Int, completionHandler: @escaping (MovieResponseModel?, ErrorModel?) -> Void) {
        movieRestApi.fetchMovies(page: page, endpoint: Endpoints.Movies.popular) { (movieList, error) in
            if let movieList = movieList {
                completionHandler(self.movieResponseModelToEntity.reverseMap(value: movieList), nil)
            } else if let error = error {
                completionHandler(nil, self.errorModelToEntity.reverseMap(value: error))
            }
        }
    }
    
    func fetchMovieDetail(id: Int, completionHandler: @escaping (MovieDetailModel?, ErrorModel?) -> Void) {
        movieRestApi.fetchMovieDetail(id: id, endpoint: Endpoints.Movies.movieDetail) { (movieDetail, error) in
            if let movieDetail = movieDetail {
                completionHandler(self.movieDetailModelToEntity.reverseMap(value: movieDetail), nil)
            } else if let error = error {
                completionHandler(nil, self.errorModelToEntity.reverseMap(value: error))
            }
        }
    }
    
    func save(movie: FavoriteMovieModel, completionHandler: @escaping (ErrorModel?) -> Void) {
        movieLocalData.save(movie: self.favoriteMovieModelToEntity.map(value: movie)) { (error) in
            guard let error = error else {
                completionHandler(nil)
                return
            }
            
            completionHandler(self.errorModelToEntity.reverseMap(value: error))
        }
    }
    
    func fetch(completionHandler: @escaping ([FavoriteMovieModel]?, ErrorModel?) -> Void) {
        movieLocalData.fetch { (movies, error) in
            if let movies = movies {
                completionHandler(self.favoriteMovieModelToEntity.reverseMap(values: movies), nil)
            } else if let error = error {
                completionHandler(nil, self.errorModelToEntity.reverseMap(value: error))
            }
        }
    }
    
    func fetch(movieId: Int, completionHandler: @escaping (FavoriteMovieModel?, ErrorModel?) -> Void) {
        movieLocalData.fetch(movieId: movieId) { (movie, error) in
            if let movie = movie {
                completionHandler(self.favoriteMovieModelToEntity.reverseMap(value: movie), nil)
            } else if let error = error {
                completionHandler(nil, self.errorModelToEntity.reverseMap(value: error))
            } else {
                completionHandler(nil, nil)
            }
        }
    }
    
    func delete(movie: FavoriteMovieModel, completionHandler: @escaping (ErrorModel?) -> Void) {
        movieLocalData.delete(movie: self.favoriteMovieModelToEntity.map(value: movie)) { (error) in
            guard let error = error else {
                completionHandler(nil)
                return
            }
            
            completionHandler(self.errorModelToEntity.reverseMap(value: error))
        }
    }
}
