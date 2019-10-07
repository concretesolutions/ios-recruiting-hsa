//
//  CoreDataRequest.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

enum CoreDataRequest{
    
    case findById(id: Int)
    
    var predicate: NSPredicate?{
        switch self {
        case .findById(id: let id):
            return NSPredicate.init(format: "id == %d", id)
        }
    }
    
}
