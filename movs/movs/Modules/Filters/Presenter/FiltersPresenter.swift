//
//  FiltersPresenter.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

protocol FiltersPresentationLogic {
    func presentFilters(filterList: [FilterModel])
    func presentValues(filterValue: [FilterModel], type: FilterType)
}

class FiltersPresenter: FiltersPresentationLogic{
    weak var view: FiltersDisplayLogic?
    
    init(view: FiltersDisplayLogic){
        self.view = view
    }
    
    func presentFilters(filterList: [FilterModel]) {
        let values = filterList.map { (filterModel) -> FilterModel in
            filterModel.isSelected = filterModel.values.contains(where: {$0.isSelected == true})
            return filterModel
        }
        let viewModel = FiltersViewModel(isRoot: true, type: .none, values: values)
        view?.updateViewModel(viewModel: viewModel)
    }
    
    func presentValues(filterValue: [FilterModel], type: FilterType) {
        let viewModel = FiltersViewModel(isRoot: false, type: type, values: filterValue)
        view?.updateViewModel(viewModel: viewModel)
    }
}
