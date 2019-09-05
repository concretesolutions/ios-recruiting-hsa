//
//  File.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/4/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import Foundation
import Alamofire

class Pelicula: NSObject, NSCoding, Decodable {
    var id:Int
    private var año:String
    var titulo: String
    var resumen:String
    var favorito:Bool
    var idGenero:[Int]
    
    private var urlImagen:String
    
    override convenience init() {
        self.init(id: 0,titulo: "Thor",año: "2008",resumen: "",idGenero: [0],favorito: false,url: "")
    }
    
    init(id:Int,titulo:String,año:String,resumen:String,idGenero:[Int],favorito:Bool,url:String) {
        self.id = id
        self.titulo = titulo
        self.año = año
        self.resumen = resumen
        self.idGenero = idGenero
        self.favorito = favorito
        self.urlImagen = url
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "id")
        let titulo = aDecoder.decodeObject(forKey: "titulo") as! String
        let año = aDecoder.decodeObject(forKey: "año") as! String
        let resumen = aDecoder.decodeObject(forKey: "resumen") as! String
        let idGenero = aDecoder.decodeObject(forKey: "idGenero") as! [Int]
        let favorito = aDecoder.decodeBool(forKey: "favorito")
        let url = aDecoder.decodeObject(forKey: "url") as! String
        
        self.init(id: id,titulo: titulo,año: año,resumen: resumen,idGenero: idGenero,favorito: favorito,url: url)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(titulo, forKey: "titulo")
        aCoder.encode(año, forKey: "año")
        aCoder.encode(resumen, forKey: "resumen")
        aCoder.encode(idGenero, forKey: "idGenero")
        aCoder.encode(favorito, forKey: "favorito")
        aCoder.encode(urlImagen, forKey: "url")
    }
    
    func getImage() -> String{
        return Constants.preImagen + self.urlImagen
    }
    func getAño() -> String{
        return String(self.año.split(separator: "-")[0])
    }
    func getGenero(completion:@escaping (String)->Void) {
        AF.request (Constants.urlGeneros).responseJSON { response in
            
            print ("Result: \(response.result)")
            
            if let data = response.data {
                print ("Result: \(data)")
                
                do{
                    let generos = try JSONDecoder().decode(ListaGeneros.self, from: data)
                    print(generos)
                    
                    //return generos.lista.fir
                    if let i = generos.lista.firstIndex(where: { $0.id == self.idGenero[0] }) {
                        print("genero=> "+generos.lista[i].nombre)
                        completion(generos.lista[i].nombre)
                    }
                    
                }
                catch{
                    print("error: \(error).")
                    
                }
                
                
            }
        }

    }
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case año = "release_date"
        case titulo = "title"
        case resumen = "overview"
        case idGenero = "genre_ids"
        case favorito = "video"
        case urlImagen = "poster_path"
    }
    
}
