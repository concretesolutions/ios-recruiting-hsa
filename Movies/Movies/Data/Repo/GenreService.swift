//
//  GenreService.swift
//  Movies
//
//  Created by Daniel Nunez on 05-03-21.
//
import Foundation
import Alamofire

class GenreServices: GenreInterface {
    
    func fetchGenres(_ completion: @escaping ([Genre]?) -> (), errorCompletion: @escaping () -> ()) {
        let path = API.genresPath()
        AF.request(path).responseJSON { response in

            switch response.result {
            case .success:

                guard response.data != nil else {
                    errorCompletion()
                    return
                }

                let decoder = JSONDecoder()

                if let genres = try? decoder.decode(
                    GenreResponse.self,
                    from: response.data!
                ) {
                    completion(genres.genres)
                }
            case .failure(_):
                errorCompletion()
            }
        }
    }

}
