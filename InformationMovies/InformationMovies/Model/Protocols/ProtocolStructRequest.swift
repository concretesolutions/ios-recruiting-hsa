//
//  ProtocolStructRequest.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 26-06-22.
//

import Foundation

protocol ProtocolStructRequest {
    
    func getURLpopularMovies() -> String
    func getURLimage(cadenaFinalImagen:String) -> String
}
