//
//  LocalMoviesRealmDB.swift
//  Concrete-Movies
//
//  Created by Audel Dugarte on 4/30/19.
//  Copyright © 2019 Audel Dugarte. All rights reserved.
//

import Foundation
import RealmSwift

class LocalMoviesRealmDB: LocalMoviesDB{
    
    
    func favoritedMoviesEntity(completionHandler: @escaping ([FavoritedMovieEntity]?, Error?) -> Void) {
        /*
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                let movies: [FavoritedMovieEntity] = realm.objects(FavoritedMovieEntity.self).map({ $0 })
                completionHandler(movies, nil)
            }
        }
        */
        let realm = try! Realm()
        let movies: [FavoritedMovieEntity] = realm.objects(FavoritedMovieEntity.self).map({ $0 })
        completionHandler(movies, nil)
    }
    
    func saveFavorited(movie: FavoritedMovieEntity) {
        DispatchQueue(label: "background").async {
            autoreleasepool {
                let realm = try! Realm()
                try! realm.write {
                    realm.add(movie)
                }
            }
        }
    }
}
