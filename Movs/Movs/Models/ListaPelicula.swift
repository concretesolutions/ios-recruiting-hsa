//
//  ListaPelicula.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/5/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import Foundation
import Alamofire

class ListaPelicula: Decodable {
    private var lista: [Pelicula] = Array()
    var total = 0
    
    func getLista() ->Array<Pelicula>{
        return self.lista
    }
    func getPopulares(exito:(() -> Void)?,falla:(() -> Void)?){
        
        AF.request (Constants.urlPopular).responseJSON { response in
            
            if let data = response.data {
                print ("Result: \(data)")
               
                do{
                    let result = try JSONDecoder().decode(ListaPelicula.self, from: data)
                    print(result)
                    self.lista = result.getLista()
                    self.total = result.total
                    if let e = exito{
                        e()
                    }
                }
                catch{
                    print("error: \(error).")
                    if let f = falla{
                        f()
                    }
                }

                
            }
        }
    }
    
    enum CodingKeys : String, CodingKey {
        case lista = "results"
        case total = "total_results"
    }
}
