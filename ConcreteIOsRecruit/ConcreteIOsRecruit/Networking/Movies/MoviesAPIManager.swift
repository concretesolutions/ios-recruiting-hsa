//
//  MoviesAPIManager.swift
//  ConcreteIOsRecruit
//
//  Created by Matías Contreras Selman on 11/18/18.
//  Copyright © 2018 Matias Contreras. All rights reserved.
//

import Foundation

struct MoviesAPIManager{
    //we can list all the other calls fot this type of object bellow and we will know which calls are being made within the app just by looking at this file
    
    func getPopularMovies(completition : @escaping([Movie]?, Error?) -> ()){
        let endpoint = PopularMoviesEndpoint()
        NetworkingManager().request(endpoint: endpoint) { (response: MoviesAPIResponse?, error) in
            
            //assign the genres to each movie
            GenreAPIManager().getGenres(completition: { (genres, error) in
                if let error = error{
                    debugPrint("Could not get the genres. Fail silently: \(error)")
                    completition(nil, error)
                }
                else{
                    
                    if var movies = response?.results, let genres = genres{
                    
                        for (i, movie) in movies.enumerated() {
                            var movieGenres = [Genre]()
                            for genreId in movie.genreIDS{
                                
                                for genre in genres {
                                    if genre.id == genreId{
                                        movieGenres.append(genre)
                                    }
                                }
                            }
                            movies[i].genres = movieGenres
                        }
                        
                    completition(movies, error)
                    }
                    
                }
            })
        }
    }
}
