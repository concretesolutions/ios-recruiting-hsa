//
//  MovieDetailQueryRouter.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/12/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

struct MovieDetailQueryRouter: DataQueryRouter{
  
    var networkRouter: ServiceRouter
    var queryPredicate: NSPredicate?
    
    init(networkRouter: MovieDetailRouter) {
        
        switch networkRouter {
        case .getDetail(let id):
            queryPredicate = NSPredicate.init(format: "id == %d", id)
        case .getImages(let id):
            queryPredicate = NSPredicate.init(format: "id == %d", id)
        case .getVideos(let id):
            queryPredicate = NSPredicate.init(format: "id == %d", id)
        }
        self.networkRouter = networkRouter
    }
    
}
