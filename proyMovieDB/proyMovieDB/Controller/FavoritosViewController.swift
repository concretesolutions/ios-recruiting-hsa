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
    func pass(anioFilt: String, generoFilt: String)
}

class FavoritosViewController: UIViewController, FavoritosViewProtocol {

    @IBOutlet weak var peliculasFavoritasTable: UITableView!
    @IBOutlet weak var limpiarFiltroButton: UIButton!
    @IBOutlet weak var barraFavoritos: UISearchBar!
    @IBOutlet weak var filtroButton: UIButton!
    
    var filtro: [DetallePelicula] = []
    var filtroPorItem: [DetallePelicula] = []
    var anioFiltrado:String = ""
    var generoFiltrado:String = ""
    var flFiltroAplicado: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barraFavoritos.delegate = self
        peliculasFavoritasTable.dataSource = self
        peliculasFavoritasTable.tableFooterView = UIView()
        peliculasFavoritasTable.register(UINib(nibName: "FavoritosTableViewCell", bundle: nil), forCellReuseIdentifier: "CeldaFavoritos")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if filtroPorItem.isEmpty && !flFiltroAplicado{
            filtro = Favoritos.shared.peliculaFav
        } else if flFiltroAplicado {
            filtro = filtroPorItem
        } else {
            filtro = Favoritos.shared.peliculaFav
        }
        
        peliculasFavoritasTable.reloadData()
        
        if filtro.count > 0 || flFiltroAplicado {
            filtroButton.isHidden = false
            if filtroPorItem.isEmpty && flFiltroAplicado{
                barraFavoritos.isEnabled = false
                barraFavoritos.text = ""
            } else {
                barraFavoritos.isEnabled = true
            }
            if flFiltroAplicado {
                barraFavoritos.text = ""
            }
        } else {
            filtroButton.isHidden = true
            barraFavoritos.isEnabled = false
            barraFavoritos.text = ""
        }
        if flFiltroAplicado {
            limpiarFiltroButton.isHidden = false
        } else {
            limpiarFiltroButton.isHidden = true
        }
    }
    
    @IBAction func onFiltroButton(_ sender: Any) {
        self.performSegue(withIdentifier: "FiltroFavoritosSegue", sender: Any.self )
    }
    
    func pass(anioFilt: String, generoFilt: String) {
        anioFiltrado = anioFilt
        generoFiltrado = generoFilt
        if anioFilt != "" || generoFilt != "" {
            filtradoBoton()
        }
    }
    
    func filtradoBoton(){
        filtroPorItem = []
//        var filtroAux:[DetallePelicula] = []
        var flContieneGenero = false
//        flFiltroAplicado = false
        if anioFiltrado != "" && generoFiltrado != "" {
            Favoritos.shared.peliculaFav.forEach { pelicula in
                if pelicula.anio.contains(anioFiltrado){
                    let objGenero:[String] = pelicula.genero
                    objGenero.forEach { genero in
                        if genero.contains(generoFiltrado) {
                            flContieneGenero = true
                        }
                    }
                    if flContieneGenero {
                        filtroPorItem.append(pelicula)
                        flFiltroAplicado = true
                        flContieneGenero = false
                    }
                }
            }
        }
        
        if anioFiltrado != "" && generoFiltrado == "" {
            Favoritos.shared.peliculaFav.forEach { pelicula in
                if pelicula.anio.contains(anioFiltrado){
                    filtroPorItem.append(pelicula)
                    flFiltroAplicado = true
                }
            }
        }
        
        if generoFiltrado != "" && anioFiltrado == "" {
            Favoritos.shared.peliculaFav.forEach { pelicula in
                let objGenero:[String] = pelicula.genero
                objGenero.forEach { genero in
                    if genero.contains(generoFiltrado) {
                        filtroPorItem.append(pelicula)
                        flFiltroAplicado = true
                    }
                }
            }
        }
        if filtroPorItem.isEmpty {
            flFiltroAplicado = true
            print("no se encontró")
        }
    }
    
    @IBAction func onLimpiarFiltro(_ sender: Any) {
        flFiltroAplicado = false
        filtro = Favoritos.shared.peliculaFav
        peliculasFavoritasTable.reloadData()
        limpiarFiltroButton.isHidden = true
        barraFavoritos.isEnabled = true
        barraFavoritos.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FiltroFavoritosSegue" {
            let viewControllerDestino: FiltroViewController = segue.destination as! FiltroViewController
//            if anioFiltrado != "" {
            if flFiltroAplicado {
                viewControllerDestino.anioFiltrado = anioFiltrado
                viewControllerDestino.anioAux = anioFiltrado
                
                viewControllerDestino.generoFiltrado = generoFiltrado
                viewControllerDestino.generoAux = generoFiltrado
            } else {
                viewControllerDestino.anioFiltrado = ""
                viewControllerDestino.anioAux = ""
                
                viewControllerDestino.generoFiltrado = ""
                viewControllerDestino.generoAux = ""
            }

//            }
//            if generoFiltrado != "" {
            
//            }
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
        
        if searchText == "" && !flFiltroAplicado {
            filtro = Favoritos.shared.peliculaFav
        } else if searchText == "" && flFiltroAplicado {
            filtro = filtroPorItem
        }
        
        Favoritos.shared.peliculaFav.forEach { pelicula in
            if pelicula.titulo.uppercased().contains(searchText.uppercased()) {
                filtro.append(pelicula)
            }
        }
        peliculasFavoritasTable.reloadData()
    }
}
