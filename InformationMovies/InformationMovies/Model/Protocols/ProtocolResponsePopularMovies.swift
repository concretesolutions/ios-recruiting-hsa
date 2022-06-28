//
//  ProtocolResponsePopularMovies.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 26-06-22.
//

import Foundation

protocol ProtocolResponsePopularMovies {
    
    var page:Int {get set}
    var results:[DataResult] {get set}
    var total_results:Int {get set}
    var total_pages:Int {get set}
}
