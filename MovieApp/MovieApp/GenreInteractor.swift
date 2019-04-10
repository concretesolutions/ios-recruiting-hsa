//
//  GenreInteractor.swift
//  MovieApp
//
//  Created by Sebastian Diaz on 4/7/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import Foundation
import Crashlytics

protocol GenreInteractorProtocol : class{
    func onfetchGenres(success:@escaping ()->Void , fail: @escaping ()->Void, timeout: @escaping ()->Void)
    func findAGenre(id : Int) -> Genre?
}

class GenreInteractor : GenreInteractorProtocol {
    
    var genresList : [Genre] = []
    
    static var shared  = GenreInteractor()
        
    func findAGenre(id : Int) -> Genre?{
        for genre in genresList {
            if genre.id == id {
                return genre
            }
        }
        return nil
    }
    
    func onfetchGenres(success:@escaping ()->Void , fail: @escaping ()->Void, timeout: @escaping ()->Void) {
        GenreAPIService.shared.getGenres(success: { (data) in
            do{
                let jsondata = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                let genres = try JSONDecoder().decode([Genre].self, from: jsondata)
                self.genresList = genres
                success()
            }catch let error {
                Crashlytics.sharedInstance().recordError(error)
                self.genresList = []
            }
        }, fail: { (code) in
            fail()
        }, timeOut: {
            timeout()
        })
    }
    
}
