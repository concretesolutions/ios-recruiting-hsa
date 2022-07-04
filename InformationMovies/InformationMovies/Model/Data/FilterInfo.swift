//
//  FilterInfo.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 30-06-22.
//

import Foundation

class FilterInfo {
    
    //MARK: Singleton
    static var shared = FilterInfo()
    
    //MARK: Propiedades
    var itemsFilter:[String]
    var yearSelected:String
    var categoriSelected:String
    var applyYear:Bool
    var applyCategory:Bool
    
    //MARK: Init
    init(itemsFilter:[String] = ["Año","Género"], yearSelected:String = String(), categoriSelected:String = String(), applyYear:Bool = false, applyCategory:Bool = false)
    {
        self.itemsFilter = itemsFilter
        self.yearSelected = yearSelected
        self.categoriSelected = categoriSelected
        self.applyYear = applyYear
        self.applyCategory = applyCategory
    }
}
