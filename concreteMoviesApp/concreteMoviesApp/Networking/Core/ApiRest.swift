//
//  ApiRest.swift
//  concreteMoviesApp
//
//  Created by Nebraska Melendez on 7/26/19.
//  Copyright © 2019 Nebraska Melendez. All rights reserved.
//

import Foundation


class ApiRest{
    

    let settings: ApiSettings
    let serviceUrl: URL

    init(settings: ApiSettings, route:String) {
        self.settings = settings
        
        guard let url = URL(string: settings.baseUrl)else {
            fatalError("URL invalida")
        }
        
        self.serviceUrl = url.appendingPathComponent(route)
            .appending("language", value: settings.language)
            .appending("api_key", value: settings.apiKey)
    }

}
