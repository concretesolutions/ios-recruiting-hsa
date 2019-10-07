//
//  FilterInteractor.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol FiltersBusinessLogic {
    func prepareFilters()
    func didSelectFilter(type: FilterType)
    func didSelectSubFilter(name: String, type: FilterType)
}

class FilterInteractor: FiltersBusinessLogic{
    
    private var filters: [FilterModel]
    private let presenter: FiltersPresentationLogic
    
    init(presenter: FiltersPresentationLogic, filters: [FilterModel]) {
        self.presenter = presenter
        self.filters = filters
    }
    
    func prepareFilters(){
        presenter.presentFilters(filterList: filters)
    }
    
    func didSelectSubFilter(name: String, type: FilterType) {
        guard let selectedFilter = filters.first(where: {$0.type == type}) else { return }
        guard let value = selectedFilter.values.first(where: {$0.name == name}) else { return }
        value.isSelected = !value.isSelected
        presenter.presentFilters(filterList: filters)
    }
    
    func didSelectFilter(type: FilterType){
        guard let filter = filters.first(where: {$0.type == type}) else { return }
        presenter.presentValues(filterValue: filter.values, type: filter.type)
    }
}
