//
//  FavoritosViewController.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 26-05-23.
//

import UIKit
import Alamofire
import AlamofireImage

class FavoritosViewController: UIViewController {

    @IBOutlet weak var peliculasFavoritasTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peliculasFavoritasTable.dataSource = self
        peliculasFavoritasTable.tableFooterView = UIView()
        peliculasFavoritasTable.register(UINib(nibName: "FavoritosTableViewCell", bundle: nil), forCellReuseIdentifier: "CeldaFavoritos")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        peliculasFavoritasTable.reloadData()
    }
}

extension FavoritosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Favoritos.shared.peliculaFav.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "CeldaFavoritos", for: indexPath) as! FavoritosTableViewCell
        let peliculaFavorita = Favoritos.shared.peliculaFav
        let objPelicula:DetallePelicula  = peliculaFavorita[indexPath.row]
        
        celda.anioPelicula.text = objPelicula.anio
        celda.descripcionPelicula.text = objPelicula.descripcion
        celda.tituloPelicula.text = objPelicula.titulo
        celda.generosPelicula.text = objPelicula.genero.formatted()
        
        AF.request(objPelicula.urlImagenPoster).responseImage {respuesta in
            if case .success(let imagen) = respuesta.result {
                celda.imagenPeliculaView.image = imagen
                celda.imagenPeliculaView.contentMode = .scaleToFill
            }
        }
        return celda
    }
}
