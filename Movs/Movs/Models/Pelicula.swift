//
//  File.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/4/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import Foundation

class Pelicula: NSObject, NSCoding {
    var id:Int
    var año:Int
    var titulo: String
    var resumen:String
    var favorito:Bool
    var idGenero:Int
    var urlImagen:String
    
    override convenience init() {
        self.init(id: 0,titulo: "Thor",año: 2008,resumen: "",idGenero: 0,favorito: false,url: "")
    }
    
    init(id:Int,titulo:String,año:Int,resumen:String,idGenero:Int,favorito:Bool,url:String) {
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
        let año = aDecoder.decodeInteger(forKey: "año")
        let resumen = aDecoder.decodeObject(forKey: "resumen") as! String
        let idGenero = aDecoder.decodeInteger(forKey: "idGenero")
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
    
    
    
}
