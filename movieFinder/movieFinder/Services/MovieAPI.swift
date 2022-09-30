//
//  MovieAPI.swift
//  movieFinder
//
//  Created by Francisco Zuniga De Spirito on 29-09-22.
//

import Foundation
import Alamofire

class MovieAPI {
    let headers: HTTPHeaders = [
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhZDYyMWQxZmFiZjRlYzM0N2NjZTViNDc0M2I5Mjc5NSIsInN1YiI6IjU4NmI5OTAzYzNhMzY4NWVhMzAwNTdkNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.spBT86jyDZQauTMYIGG-Q6nTAVSTZ0v1I-c73HonPus",
        "Accept": "application/json"
    ]
    
    func getPopularMovies(_ responseHandler: @escaping ([RealmMovieItem]) -> Void) {

        
        AF.request("https://api.themoviedb.org/3/movie/popular?api_key=ad621d1fabf4ec347cce5b4743b92795&page=1", headers: headers).responseDecodable(of: popularMoviesResponseType.self) { response in
            
            if response.error == nil {
                if let movieList = response.value {
                    let realmMovieList = movieList.results.map { item in
                        let realmItem = RealmMovieItem()
                        realmItem.name = item.original_title
                        realmItem.id = item.id
                        realmItem.posterImageURL = "https://image.tmdb.org/t/p/w185" + "\(item.poster_path)"
                        return realmItem
                    }
                                        
                    responseHandler(realmMovieList)
                }
            }
        }
    }
        

        
    func getMovieDetail(_ id: Int, _ responseHandler: @escaping (RealmMovieItem) -> Void) {
        AF.request("https://api.themoviedb.org/3/movie/" + "\(id)" + "?api_key=ad621d1fabf4ec347cce5b4743b92795", headers: headers).responseDecodable(of: movieDetailType.self) { response in
            if response.error == nil {
                if let movieDetail = response.value {
                    let realmItem = RealmMovieItem()
                    realmItem.backdropImageURL = "https://image.tmdb.org/t/p/w780" + "\(movieDetail.backdrop_path)"
                    realmItem.descriptionText = movieDetail.overview
                    realmItem.name = movieDetail.original_title
                    realmItem.releaseDate = movieDetail.release_date
                    var genresString = ""
                    movieDetail.genres.map({ item in
                        genresString.append(" ")
                        genresString.append(item.name)
                        genresString.append(",")
                    })
                    
                    realmItem.genres = genresString.trimmingCharacters(in: .whitespaces).trimmingCharacters(in: .punctuationCharacters)
                    
                    responseHandler(realmItem)
                }
            }
        }
    }
}

