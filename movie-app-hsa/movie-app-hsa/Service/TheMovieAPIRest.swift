//
//  TheMovieAPIRest.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import Foundation
import Alamofire

class TheMovieAPIRest {

    // MARK: Properties
    let url_base: String = "https://api.themoviedb.org/3"
    let token: String = "6aedc7e1349584ac9224e8d9670af8a8"
    
    //MARK: Method popularMovie
    func popularMovie(page: Int, maxPage: Int, complete : @escaping (_ status : APIStatusType, _ messsage: PopularMovieResponse?) -> ()) {
        
        print("page: \(page)")
        
        if page > maxPage {
            complete(.maxPage, nil)
            return
        }

        let context = "\(url_base)/movie/popular?api_key=\(token)&language=en-US&page=\(page)"

       // print(context)

        AF.request(context).response { response in
            //print(response)
            
            if response.error != nil {
                complete(.apiCallError, nil)
                return
            }
            guard let data = response.data else {
                complete(.noData, nil)
                return
            }
            do {
                let popularMovieResponse = try JSONDecoder().decode(PopularMovieResponse.self, from: data)
                if (popularMovieResponse.success ?? true) {
                    print("page: \(popularMovieResponse.page)")
                    print("total pages: \(popularMovieResponse.totalPages)")
                    complete(.success, popularMovieResponse)
                    return
                } else {
                    complete(.unsuccessfully, nil)
                    return
                }
            } catch let error {
                print(error)
                complete(.errorProcessingContent, nil)
                return
            }
         }
    }

    //MARK: Method listMovie
    func listMovie(complete : @escaping (_ status : APIStatusType, _ messsage: ListMovieResponse?) -> ()) {

        // https://api.themoviedb.org/3/genre/movie/list?api_key=6aedc7e1349584ac9224e8d9670af8a8&language=en-US

        let context = "\(url_base)/genre/movie/list?api_key=\(token)&language=en-US"

        print(context)
        AF.request(context).response { response in
            //print ("response:")
            //debugPrint(response)

            if response.error != nil {
                complete(.apiCallError, nil)
                return
            }
            guard let data = response.data else {
                complete(.noData, nil)
                return
            }
            do {
                let listMovieResponse = try JSONDecoder().decode(ListMovieResponse.self, from: data)
                print("*** resultado ***\n")

                if (listMovieResponse.success ?? true) {
                    complete(.success, listMovieResponse)
                    return
                } else {
                    complete(.unsuccessfully, nil)
                    return
                }

            } catch let error {
                print(error)
                complete(.errorProcessingContent, nil)
                return
            }
         }
    }
}
