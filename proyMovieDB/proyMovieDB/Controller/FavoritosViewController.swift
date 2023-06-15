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
    @IBOutlet weak var imagenInformativa: UIImageView!
    @IBOutlet weak var textoInformativo: UILabel!
    
    var filtro: [DetallePelicula] = []
    var filtroPorItem: [DetallePelicula] = []
    var anioFiltrado:String = ""
    var generoFiltrado:String = ""
    var flFiltroAplicado: Bool = false
    var idPelicula:[Int] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        barraFavoritos.delegate = self
        peliculasFavoritasTable.dataSource = self
        peliculasFavoritasTable.delegate = self
        peliculasFavoritasTable.tableFooterView = UIView()
        peliculasFavoritasTable.register(UINib(nibName: "FavoritosTableViewCell", bundle: nil), forCellReuseIdentifier: "CeldaFavoritos")
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bajarTeclado))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let idPeliculasPersistentes:[Int] = UserDefaults.standard.object(forKey: "keyID") as? [Int] {
            idPelicula = idPeliculasPersistentes
        }
        
        setearEstadoObjetos()
        recargarDatos(texto: barraFavoritos.text ?? "")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        UserDefaults.standard.set(idPelicula, forKey: "keyID")
        UserDefaults.standard.synchronize()
    }
    
    func eliminarIdPelicula(idPeli:Int) {
        
        var indice:Int = 0
        idPelicula.forEach { peliculaPersistente in
            if peliculaPersistente == idPeli {
                indice = idPelicula.firstIndex(of: peliculaPersistente) ?? 0
            }
        }
        idPelicula.remove(at: indice)
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
        var flContieneGenero = false
        
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
        }
    }
    
    @IBAction func onLimpiarFiltro(_ sender: Any) {
        
        flFiltroAplicado = false
        peliculasFavoritasTable.reloadData()
        limpiarFiltroButton.isHidden = true
        recargarDatos(texto: barraFavoritos.text ?? "")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FiltroFavoritosSegue" {
            let viewControllerDestino: FiltroViewController = segue.destination as! FiltroViewController
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
            
            viewControllerDestino.delegate = self
        }
    }
    
    func setearEstadoObjetos() {
        
        if Favoritos.shared.peliculaFav.count == 0 {
            imagenInformativa.image = UIImage(systemName: "exclamationmark.icloud.fill")
            imagenInformativa.isHidden = false
            textoInformativo.text = "Aún no has añadido ninguna película favorita"
            peliculasFavoritasTable.isHidden = true
            barraFavoritos.text = ""
            barraFavoritos.isEnabled = false
            filtroButton.isHidden = true
            limpiarFiltroButton.isHidden = true
        } else if filtro.count < 1 {
            imagenInformativa.image = UIImage(systemName: "magnifyingglass")
            imagenInformativa.isHidden = false
            textoInformativo.text = "No se ha encontrado ninguna película con ese filtro"
            peliculasFavoritasTable.isHidden = true
            filtroButton.isHidden = false
            barraFavoritos.isEnabled = true
        } else {
            imagenInformativa.isHidden = true
            textoInformativo.text = String()
            peliculasFavoritasTable.isHidden = false
            barraFavoritos.isEnabled = true
            if flFiltroAplicado {
                limpiarFiltroButton.isHidden = false
            } else {
                limpiarFiltroButton.isHidden = true
            }
        }
    }
    
    func recargarDatos(texto: String){
        
        filtro = []
        
        if texto == "" && !flFiltroAplicado {
            filtro = Favoritos.shared.peliculaFav
        } else if texto == "" && flFiltroAplicado {
            pass(anioFilt: anioFiltrado, generoFilt: generoFiltrado)
            filtro = filtroPorItem
        }
        
        Favoritos.shared.peliculaFav.forEach { pelicula in
            if pelicula.titulo.uppercased().contains(texto.uppercased()) {
                filtro.append(pelicula)
            }
        }
        peliculasFavoritasTable.reloadData()
        setearEstadoObjetos()
    }
    
    @objc func bajarTeclado() {
        view.endEditing(true)
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

extension FavoritosViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let eliminar = UIContextualAction(style: .destructive, title: "Eliminar") { (action, view, completionHandler) in
            
            var indiceArregloFavoritos: Int = 0
            var idPelicula: Int
            
            idPelicula = self.filtro[indexPath.row].id
            Favoritos.shared.peliculaFav.forEach { peli in
                if peli.id == idPelicula {
                    indiceArregloFavoritos = Favoritos.shared.peliculaFav.firstIndex(of: peli) ?? 0
                }
            }
            
            Favoritos.shared.peliculaFav.remove(at: indiceArregloFavoritos)
            self.eliminarIdPelicula(idPeli: idPelicula)
            
            self.setearEstadoObjetos()
            self.recargarDatos(texto: self.barraFavoritos.text ?? "")
        }
        return UISwipeActionsConfiguration(actions: [eliminar])
    }
}

extension FavoritosViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        recargarDatos(texto: searchText)
    }
}


