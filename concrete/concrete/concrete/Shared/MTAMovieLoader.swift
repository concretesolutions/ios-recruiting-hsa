//
//  MTAMovieLoader.swift
//  MovieApp
//
//  Created by Andres Ortiz on 4/17/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit


class MTAMovieLoader {
    static let shared = MTAMovieLoader()
    init() {}
    
    var movie : Movie? = nil
    var movieCategoryPath : String?
    var movieSearchText: String?
    
    func fetchMovieVideo(movieId: Int64, completion: @escaping (_ result: String, _ success: Bool) -> Void)
    {
        
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=30f03a109d382c80fe5ef86868633ff7")
        
        let request = URLRequest(url: url! as URL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("error=\(error)")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let search = try decoder.decode(Media.self, from: data!)
                    let video = search.results.first
                    if ((video) != nil){
                        let path = video?.key
                        completion(path!,true)
                    }
                    else{
                        completion("FJkr_TwfwZg",true)
                    }
                }
                catch let jsonError {
                    print("Failed to decode ", jsonError)
                    completion("FJkr_TwfwZg",true)
                }
            }
        }.resume()
        
        
    }
    
    func fetchMovies(kind: Int, page: Int, text: String, completion: @escaping (_ result: [Movie], _ success: Bool) -> Void) {

        
        movieSearchText = text

        let isConnected = MTAReachability.shared.isConnected()
        
        movieCategoryPath = "popular"
        var category = "popular"

        switch kind {
        case 2:
            category = "top_rated"
            movieCategoryPath = "topRated"
        default:
            category = "popular"
            movieCategoryPath = "popular"
        }
        
        
        if isConnected
        {

            
            var url = NSURL(string: "https://api.themoviedb.org/3/movie/\(category)?api_key=34738023d27013e6d1b995443764da44&page=\(page)")
            
            if(text != "")
            {
                let urledText = text.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
                url = NSURL(string: "https://api.themoviedb.org/3/search/movie?api_key=34738023d27013e6d1b995443764da44&page=\(page)&query=\(urledText ?? "")")
            }
            
            let request = URLRequest(url: url! as URL)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        print("error=\(error)")
                        return
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let search = try decoder.decode(Search.self, from: data!)
                        let movies = search.results
                        if(self.movieSearchText == ""){
                            MTAMovieStorage.shared.saveAllOnDisk(movies: movies, category: self.movieCategoryPath!)
                        }
                        completion(movies, true)

                    }
                    catch let jsonError {
                        print("Failed to decode ", jsonError)
                        completion([], false)
                    }
                }
                }.resume()
        }
        else
        {
            let movieStorage = MTAMovieStorage.shared
            movieStorage.loadDataFromFile()
            if(text != ""){
                var movieArray = movieStorage.retrieveArray(category:self.movieCategoryPath!)
                movieArray = movieArray.filter { $0.title.contains (text) }
                completion(movieArray, true)
            }
            else{
                completion(movieStorage.retrieveArray(category:self.movieCategoryPath!), true)
            }
        }
        
    }
    

    
}
