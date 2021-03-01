//
//  GenreServices.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/28/21.
//

import Foundation
import Alamofire

class GenreServices {

    class func getGenres(successBlock: @escaping ([Genre]) -> (), errorBlock: @escaping () -> ()) {
        let path = API.getPath(for: .genres)
        AF.request(path).responseJSON { response in
            guard let data = response.data else {
                errorBlock()
                return
            }
            do {
                let decoder = JSONDecoder()
                if let genreResponse = try? decoder.decode(GenreResponse.self, from: data), let genres = genreResponse.genres {
                    successBlock(genres)
                } else {
                    errorBlock()
                }
            }
        }
    }

}
