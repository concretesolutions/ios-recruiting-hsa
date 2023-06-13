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
    @IBOutlet weak var filtrosTableView: UITableView!
    @IBOutlet weak var aplicarButton: UIButton!
    
    var anioFiltrado:String = ""
    var generoFiltrado:String = ""
    var arregloTipoFiltro:[String] = ["Año","Género"]
    var filtro: [DetallePelicula] = []
    var delegate:FavoritosViewProtocol?
    var flFiltroAplicado = false
    var anioAux:String = ""
    var generoAux:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filtrosTableView.dataSource = self
        filtrosTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filtro = Favoritos.shared.peliculaFav
        filtrosTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if flFiltroAplicado || (anioAux == anioFiltrado && generoAux == generoFiltrado) {
            delegate?.pass(anioFilt: anioFiltrado, generoFilt: generoFiltrado)
        } else if !flFiltroAplicado && (anioAux != anioFiltrado || generoAux != generoFiltrado) {
            delegate?.pass(anioFilt: anioAux, generoFilt: generoAux)
        } else {
            delegate?.pass(anioFilt: "", generoFilt: "")
        }
    }
    
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
        if anioFiltrado == "" && generoFiltrado == "" {
            //seleccionar valor válido
            flFiltroAplicado = false
            alertaAviso(tituloAlerta: "No ha seleccionado ningún filtro", mensaje: "Por favor selecciona al menos un valor para alguno de los filtros", tituloOK: "OK")
        } else {
            flFiltroAplicado = true
            self.dismiss(animated: true)
        }
    }
    
    func alertaAviso(tituloAlerta: String, mensaje: String, tituloOK: String){
        let alert = UIAlertController(title: tituloAlerta, message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: tituloOK, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
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
