//
//  FiltersViewModel.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

struct FiltersViewModel {
    var isRoot: Bool
    var type: FilterType
    var values: [FilterModel]
    
    func getFiltersCount()->Int?{
        if !isRoot{
            return values.first(where: {$0.type == type})?.values.count
        }else{
            return values.count
        }
    }
    
    func getFilterName(at index: Int)-> String?{
        if isRoot{
            let filterModel = values[safe: index]
            let numberOfSelected = filterModel?.values.map{$0.isSelected ? 1:  0}.reduce(0, +) ?? 0
            guard let filterTitle = filterModel?.title else { return nil }
            let title = numberOfSelected > 0 ? "\(filterTitle)(\(numberOfSelected))" : filterTitle
            return title
        }else{
            return getFilter(at: index)?.name
        }
    }
    
    func getFilter(at index: Int)-> FilterValue?{
        return values.first(where: {$0.type == type})?.values[safe: index]
    }
}

