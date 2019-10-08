//
//  CoreDataRouter.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/12/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import CoreData

protocol DataQueryRouter{
    var queryPredicate: NSPredicate?{ get }
    var networkRouter: ServiceRouter{ get }
}
