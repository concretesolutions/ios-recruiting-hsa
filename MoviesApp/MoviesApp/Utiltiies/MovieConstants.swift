//
//  Constants.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import Foundation

//MARK: -URLS The Api Movies
struct APIUrl{
    static let appiKey = "429bd6eb3ae6496210731b951f6d6f95"
    static let moviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=" + appiKey + "&language=en-US&page=1"
    static let genresURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=" + appiKey + "&language=en-US"
    static let routeImage = "https://image.tmdb.org/t/p/original/"
}

//MARK: - IDs of the cells
struct Cells{
    static let movieCell = "MovieCollectionViewCell"
    static let movieFavoriteCell = "CellFavoriteMovie"
    static let movieFilterCell = ""
    static let movieFilterDetailCell = ""
}
//MARK: -Ids of the storyboards
struct StoryBoardsIDS{
    static let idDetailMovie = "DetailMovieViewController"
}

//MARK: - Mesages of Alerts
struct AlertConstant{
    static let OK = "OK"
    static let Error = "Movies error!!!"
    static let ErrorMissingInfo = "La busquda no encontro resultados "
}

struct ColorsMovie{
    static let Yellow = "ColorMVYellowLight"
}
