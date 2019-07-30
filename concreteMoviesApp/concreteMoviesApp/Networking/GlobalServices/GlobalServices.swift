//
//  GlobalServices.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/26/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation

class GlobalServices{
    
    private let apiSettings: ApiSettings
    static let shared:GlobalServices = GlobalServices()
    
    //MARK: - Services
    let movieServices:MovieServices
    let genreServices:GenreServices
    
    private init(){
        
        self.apiSettings = ApiSettings.init(
            baseUrl: "https://api.themoviedb.org/3",
            apiKey: "6caad4b2a15217cc1611598f3f79910a",
            language: "en-US"
        )
        
        self.movieServices = MovieServices(settings: apiSettings, route: "/movie/popular")
        self.genreServices = GenreServices(settings: apiSettings, route: "/genre/movie/list")
    }
    
}
