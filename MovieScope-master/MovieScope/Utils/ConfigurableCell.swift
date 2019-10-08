//
//  ConfigurableCell.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/3/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

//Protocolo para que celdas de tableview y collectionview
//puedan poseer viewModels y manejar una logica compleja de forma limpia y organizada
protocol ConfigurableCell{
    func setViewModel(viewModel: HomeCellViewModel)
    static var reuseIdentifier: String{ get }
}
