//
//  EntidadNumeroFila+CoreDataProperties.swift
//  
//
//  Created by Cristian Bahamondes on 28-06-22.
//
//

import Foundation
import CoreData


extension EntidadNumeroFila {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EntidadNumeroFila> {
        return NSFetchRequest<EntidadNumeroFila>(entityName: "EntidadNumeroFila")
    }

    @NSManaged public var numFila: Int32
    @NSManaged public var idMovie: Int64

}
