//
//  MovieListRouter.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/13/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

struct MovieListQueryRouter: DataQueryRouter{
    
    var networkRouter: ServiceRouter
    var queryPredicate: NSPredicate?
    
    init(networkRouter: HomeRouter, categoryId: String) {
        
        switch networkRouter {
        case .popular(let page):
            queryPredicate = NSPredicate.init(format: "page == %d AND categoryId == %@", page, categoryId)
        case .topRated(let page):
            queryPredicate = NSPredicate.init(format: "page == %d AND categoryId == %@", page, categoryId)
        case .upcoming(let page):
            queryPredicate = NSPredicate.init(format: "page == %d AND categoryId == %@", page, categoryId)
        case .search(_):
            queryPredicate = nil
        }
        self.networkRouter = networkRouter
    }
    
}
