//
//  ValoresFiltrosViewController.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 11-06-23.
//

import UIKit

class ValoresFiltrosViewController: UIViewController {
    
    var flAnio:Bool = true
    var arregloDatos = Favoritos.shared.peliculaFav
    var aniosAux: Set<String> = []
    var anios:[String] = []
    var anio:String = ""
    var genero:String = ""
    var delegate: FiltroViewProtocol?

    @IBOutlet weak var filtroAplicado: UILabel!
    @IBOutlet weak var filtroSeleccionadoTableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        filtroSeleccionadoTableView.dataSource = self
        filtroSeleccionadoTableView.delegate = self
        
        if flAnio {
            filtroAplicado.text = "Año"
            eliminarAnioRepetido()
        } else {
            filtroAplicado.text = "Género"
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
        if flAnio {
            delegate?.pass(anioSelec: anio, generoSelec: "")
        } else {
            delegate?.pass(anioSelec: "", generoSelec: genero)
        }
    }
    
    @IBAction func onBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func eliminarAnioRepetido() {
       
        ResponsesPelisPopulares.shared.results.forEach { peli in
            let anio = String(peli.release_date.prefix(4))
            aniosAux.insert(anio)
        }
        
        aniosAux.forEach { indice in
            anios.append(indice)
        }
    }
}

extension ValoresFiltrosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if flAnio {
            return anios.count
        } else {
            return ResponseGeneros.shared.genres.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let celda:ValoresFiltrosTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CeldaFiltroAplicado", for: indexPath) as! ValoresFiltrosTableViewCell
        
        if flAnio {
            celda.valorFiltroEspecifico.text = anios[indexPath.row]
        } else {
            celda.valorFiltroEspecifico.text = ResponseGeneros.shared.genres[indexPath.row].name
        }
        return celda
    }
}

extension ValoresFiltrosViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if flAnio {
            anio = anios[indexPath.row]
        } else {
            genero = ResponseGeneros.shared.genres[indexPath.row].name
        }
        self.dismiss(animated: true)
    }
}
