//
//  DetailMoviePresenter.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 18/06/22.
//

import Foundation
import UIKit
import CoreData

protocol DetailMoviePresenterDelegate: AnyObject{
    func presentGender(gender:String)
    func showError(error:Error)
    func showFavorite()
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

    func saveFavorite(movie:Movie){
     
        //let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //let context:NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "MovieDB", in: context)
        let movieFavorite = MovieDB(entity: entity!, insertInto: context)
        movieFavorite.poster = movie.poster_path
        movieFavorite.title = movie.title
        movieFavorite.releaseYear = (movie.getYear() as NSString).intValue
        movieFavorite.sinopsis = movie.overview
        movieFavorite.idMovieDB = movie.id as NSNumber
        
        do{
            try context.save()
        } catch{
            print(error)
        }
        self.delegate?.showFavorite()
        
    }

    private  func getContext() -> NSManagedObjectContext {
        let appDelegate: AppDelegate
        if Thread.current.isMainThread {
            appDelegate = UIApplication.shared.delegate as! AppDelegate
        } else {
            appDelegate = DispatchQueue.main.sync {
                return UIApplication.shared.delegate as! AppDelegate
            }
        }
        return appDelegate.persistentContainer.viewContext
    }
}

