//
//  FiltersWorker.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import Foundation

class FiltersWorker {
    //MARK: - Memory debug
    
    deinit {
        print("Filters Worker dealloc")
    }
    
    //MARK: - Retrieve Filters
    
    func retrieveFilters() -> [Filter<String>] { //Por ahora va a ser un filtro de strings pero si se requiere otros tipos de filtros faltarían filtros como Por Ejemplo Filter<Int>. Para ello se debe ocupar un patron de fabricacion pura.
        return [Filter<String>("Date"),Filter<String>("Genre")]
    }
}
