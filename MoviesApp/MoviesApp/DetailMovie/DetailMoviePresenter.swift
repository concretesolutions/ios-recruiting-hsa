//
//  DetailMoviePresenter.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 18/06/22.
//

import Foundation
import UIKit

protocol DetailMoviePresenterDelegate: AnyObject{
    func presentGender(gender:String)
    func showError(error:Error)
}

typealias PresenterDetailMovieDelegate = DetailMoviePresenterDelegate & UIViewController


class DetailMoviePresenter{
    weak var delegate: PresenterDetailMovieDelegate?
    
    public func setViewDelegate(delegate: PresenterDetailMovieDelegate){
        self.delegate = delegate
    }
    
    func getGenres(genreIDS:[Int]) {
        guard let url = URL(string: APIUrl.genresURL) else {return}
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                self.delegate?.showError(error: urlFail.fail)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let  genresData = try decoder.decode(Genres.self,from:data)
                
                let  genresMovies =  genresData.genres.filter{
                    item in genreIDS.contains(item.id )
                }
                let resultGenre = genresMovies.map{$0.name}.joined(separator: ",")
                
                self.delegate?.presentGender(gender: resultGenre)
            }catch{
                print(error)
                self.delegate?.showError(error: error)
            }
           
        }
        task.resume()
    }
}
