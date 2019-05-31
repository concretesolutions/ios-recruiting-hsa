//
//  Constant.swift
//  ios-recruiting-hsa
//
//  Created by Hans Fehrmann on 5/27/19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import Foundation

enum Constants {

    enum PersistanceKeys {
        static let favoritesMovies = "FavoritesMovies"
    }

    static let apiKey: String = {
        let adas = "adasasd"
        guard let path = Bundle.main.path(forResource: "Secret", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let apiKey = plist["ApiKey"] as? String
        else {
            fatalError(#"File "Secret.plist" is not present in project"#)
        }
        return apiKey
    }()

}
