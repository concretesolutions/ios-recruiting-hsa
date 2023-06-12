//
//  FiltroViewController.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 11-06-23.
//

import UIKit

protocol FiltroViewProtocol {
    func pass(anioSelec: String, generoSelec: String)
}

class FiltroViewController: UIViewController, FiltroViewProtocol {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var aplicarButton: UIButton!
    @IBOutlet weak var filtrosTableView: UITableView!

    var anioFiltrado:String = ""
    var generoFiltrado:String = ""
    var arregloTipoFiltro:[String] = ["Año","Género"]
    var filtro: [DetallePelicula] = []
    var delegate:FavoritosViewProtocol?
    var flFiltroAplicado = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filtrosTableView.dataSource = self
        filtrosTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filtro = Favoritos.shared.peliculaFav
        filtrosTableView.reloadData()
    }
    /*
    override func viewWillDisappear(_ animated: Bool) {
        if flFiltroAplicado {
            delegate?.pass(arregloFiltro: filtro)
        } else {
            delegate?.pass(arregloFiltro: Favoritos.shared.peliculaFav)
        }
    }
    */
    @IBAction func onBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func pass(anioSelec: String, generoSelec: String) {
        if anioSelec != "" {
            anioFiltrado = anioSelec
        }
        if generoSelec != "" {
            generoFiltrado = generoSelec
        }
    }
    
    @IBAction func onAplicarButton(_ sender: Any) {
        filtro = []
//        var filtroAux:[DetallePelicula] = []
        var flOK = false
        flFiltroAplicado = false
        
        if anioFiltrado != "" && generoFiltrado != "" {
            Favoritos.shared.peliculaFav.forEach { pelicula in
                if pelicula.anio.contains(anioFiltrado){
                    let objGenero:[String] = pelicula.genero
                    objGenero.forEach { genero in
                        if genero.contains(generoFiltrado) {
                            flOK = true
                        }
                    }
                    if flOK {
                        filtro.append(pelicula)
                        flFiltroAplicado = true
                        flOK = false
                    }
                }
            }
        }
        
        if anioFiltrado != "" && generoFiltrado == "" {
            Favoritos.shared.peliculaFav.forEach { pelicula in
                if pelicula.anio.contains(anioFiltrado){
                    filtro.append(pelicula)
                    flFiltroAplicado = true
                }
            }
        }
        
        if generoFiltrado != "" && anioFiltrado == "" {
            Favoritos.shared.peliculaFav.forEach { pelicula in
                let objGenero:[String] = pelicula.genero
                objGenero.forEach { genero in
                    if genero.contains(generoFiltrado) {
                        filtro.append(pelicula)
                        flFiltroAplicado = true
                    }
                }
            }
        }
    }
}

extension FiltroViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arregloTipoFiltro.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda:FiltrosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CeldaFiltro", for: indexPath) as! FiltrosTableViewCell
        
        let objFiltro = arregloTipoFiltro[indexPath.row]
        
        celda.tipoFiltro.text = objFiltro
        if indexPath.row == 0 {
            celda.valorFiltro.text = anioFiltrado
        } else {
            celda.valorFiltro.text = generoFiltrado
        }
        
        celda.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return celda
    }
}

extension FiltroViewController: UITableViewDelegate {
//    seleccionar celda de tabla
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indice = indexPath.row
        self.performSegue(withIdentifier: "CeldaFiltro", sender: indice)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CeldaFiltro" {
            let idRecibido = sender as! Int
            let viewControllerDestino: ValoresFiltrosViewController = segue.destination as! ValoresFiltrosViewController
            viewControllerDestino.delegate = self
            
            if idRecibido == 0 {
                //filtro por año
                viewControllerDestino.flAnio = true
            } else {
                //filtro por genero
                viewControllerDestino.flAnio = false
            }
        }
    }
}
