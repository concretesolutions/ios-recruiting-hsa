//
//  FavoritosViewController.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 26-05-23.
//

import UIKit
import Alamofire
import AlamofireImage

protocol FavoritosViewProtocol {
    func pass(arregloFiltro:[DetallePelicula])
}

class FavoritosViewController: UIViewController, FavoritosViewProtocol {

    @IBOutlet weak var peliculasFavoritasTable: UITableView!
    @IBOutlet weak var barraFavoritos: UISearchBar!
    @IBOutlet weak var filtroButton: UIButton!
    
    var filtro: [DetallePelicula] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barraFavoritos.delegate = self
        peliculasFavoritasTable.dataSource = self
        peliculasFavoritasTable.tableFooterView = UIView()
        peliculasFavoritasTable.register(UINib(nibName: "FavoritosTableViewCell", bundle: nil), forCellReuseIdentifier: "CeldaFavoritos")
        
        filtro = Favoritos.shared.peliculaFav
    }
    
    override func viewWillAppear(_ animated: Bool) {
        peliculasFavoritasTable.reloadData()
        
        if filtro.count > 0 {
            filtroButton.isHidden = false
        } else {
            filtroButton.isHidden = true
        }
    }
    
    @IBAction func onFiltroButton(_ sender: Any) {
        self.performSegue(withIdentifier: "FiltroFavoritosSegue", sender: Any.self )
    }
    
    func pass(arregloFiltro: [DetallePelicula]) {
//        filtro = arregloFiltro
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FiltroFavoritosSegue" {
            let viewControllerDestino: FiltroViewController = segue.destination as! FiltroViewController
            viewControllerDestino.delegate = self
        }
    }
}

extension FavoritosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tableView.dequeueReusableCell(withIdentifier: "CeldaFavoritos", for: indexPath) as! FavoritosTableViewCell
        // let peliculaFavorita = Favoritos.shared.peliculaFav
        let objPelicula:DetallePelicula  = filtro[indexPath.row]
        
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

extension FavoritosViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtro = []
        
        if searchText == "" {
            filtro = Favoritos.shared.peliculaFav
        }
        Favoritos.shared.peliculaFav.forEach { pelicula in
            if pelicula.titulo.uppercased().contains(searchText.uppercased()) {
                filtro.append(pelicula)
            }
        }
        peliculasFavoritasTable.reloadData()
    }
}
