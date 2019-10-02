//
//  Enviroment.swift
//  Re-Counter
//
//  Created by Andrés Alexis Rivas Solorzano on 7/29/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation

struct Enviroment{
    
    let host: String
    
    init(host: Host = .moviedb){
        self.host = host.rawValue
    }

}
