//
//  MovieListService.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/27/21.
//

import Foundation
import Alamofire

class MovieServices {

    class func getMovies(page: Int = 1, successBlock: @escaping ([Movie]) -> (), errorBlock: @escaping () -> ()) {
        let path = API.getPath(for: .movies(page: page))
        AF.request(path).responseJSON { response in
            guard let data = response.data else {
                errorBlock()
                return
            }
            do {
                let decoder = JSONDecoder()
                if let movieResponse = try? decoder.decode(MovieResponse.self, from: data), let movies = movieResponse.results {
                    successBlock(movies)
                } else {
                    errorBlock()
                }
            }
        }
    }

}
