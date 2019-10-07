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
    func presentValues(filterValue: [FilterValue], type: FilterType)
}

class FiltersPresenter: FiltersPresentationLogic{
    weak var view: FiltersDisplayLogic?
    
    init(view: FiltersDisplayLogic){
        self.view = view
    }
    
    func presentFilters(filterList: [FilterModel]) {
        let values = filterList.map { (filterModel) -> FilterValue in
            let isSelected = filterModel.values.contains(where: {$0.isSelected == true})
            let numberOfSelected = filterModel.values.map{$0.isSelected ? 1:  0}.reduce(0, +)
            let title = numberOfSelected > 0 ? "\(filterModel.title)(\(numberOfSelected))" : filterModel.title
            return FilterValue(isSelected: isSelected, name: title)
        }
        let viewModel = FiltersViewModel(isRoot: true, type: .none, values: values)
        view?.updateViewModel(viewModel: viewModel)
    }
    
    func presentValues(filterValue: [FilterValue], type: FilterType) {
        let viewModel = FiltersViewModel(isRoot: false, type: type, values: filterValue)
        view?.updateViewModel(viewModel: viewModel)
    }
}
