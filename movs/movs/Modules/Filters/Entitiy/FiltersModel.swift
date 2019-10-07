//
//  FiltersModel.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

enum FilterType{
    case none
    case date
    case genre
}

class FilterValue {
    var isSelected: Bool
    var name: String
    var coreDataId: String
    
    init(isSelected: Bool, name: String, coreDataId: String) {
        self.isSelected = isSelected
        self.coreDataId = coreDataId
        self.name = name
    }
}

class FilterModel{
    var title: String
    var type: FilterType
    var values: [FilterValue]
    var isSelected = false
    
    init(title: String, type: FilterType, values: [FilterValue]) {
        self.title = title
        self.type = type
        self.values = values
    }
}
