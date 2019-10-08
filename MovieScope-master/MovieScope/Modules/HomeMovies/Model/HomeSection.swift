//
//  HomeSectionsDefinitions.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/3/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

//NOTA: En este archivo estan los enums correspondientes a los tipos de secciones y a los identificadores de fila de esas secciones, en caso de que crezcan demasiado se pueden mover a un archivo aparte pero a efectos de la prueba se dejaron en el mismo .swift
enum HomeHeadersIdentifiers: String{
    case homeHeader = "HeaderHome"
}


//Las secciones que se mostraran en el home. En el caso de que el negocio desee añadir una nueva sección. Ej: Recomendadas. Solo habria que añadirla al enum como un case, tal como se muestra en el comentario, para que se integre a la tabla del home. Cada tipo de seccion contiene un tipo de celda para sus filas.
enum HomeSectionType: String, CaseIterable{
    
    case upcoming = "Upcoming"
    case topRated = "Top Rated"
    case popular = "Popular"
//    case recommended = "Recommended"
    
    var rowCellType: ConfigurableCell.Type{
        switch self {
        case .topRated:
            return TopRatedMovieTableViewCell.self
        case .popular:
            return PopularMovieTableViewCell.self
        case .upcoming:
            return UpComingMoviesTableViewCell.self
        }
    }
}


class HomeSection{
    
    var type: HomeSectionType
    var viewModel: HomeCellViewModel
    var movieList: MovieListModel
    
    //Wrapper para obtener el reuseIdentifier de la celda sin necesidad de escribir tanto.
    var reuseIdentifier: String{
        return type.rowCellType.reuseIdentifier
    }
    
    init(type: HomeSectionType, movieList: MovieListModel) {
        self.type = type
        self.movieList = movieList
        self.viewModel = HomeCellViewModel.init(movieList: movieList.results)
    }
    
}
