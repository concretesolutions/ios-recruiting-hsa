//
//  SearchQueryRouter.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/13/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

struct SearchQueryRouter: DataQueryRouter{
    
    var queryPredicate: NSPredicate?
    var networkRouter: ServiceRouter
    
    init(networkRouter: HomeRouter, catId: String){
        
        switch networkRouter {
        case .search(let query, _):
            queryPredicate =  NSPredicate.init(format: "title CONTAINS[cd] %@", query)
        default:
            queryPredicate = NSPredicate.init(format: "categoryId == %@", catId)
        }
        self.networkRouter = networkRouter
   
    }
}
