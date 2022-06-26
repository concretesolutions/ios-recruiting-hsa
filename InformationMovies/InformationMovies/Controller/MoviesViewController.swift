//
//  MoviesViewController.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 25-06-22.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableMovies: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableMovies.dataSource = self
        tableMovies.delegate = self
        tableMovies.tableFooterView = UIView()
        tableMovies.register(UINib(nibName: "MoviesAllCell", bundle: nil), forCellReuseIdentifier: "CeldaALLMovies")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5 //Retornar la cantidad total del arreglo
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaALLMovies", for: indexPath) as! MoviesAllCell
        
        cell.nombrePeliculaLabel.text = "Interestellar"
        cell.DescripcionTextView.text = "Un texto es una composición de signos codificados en un sistema de escritura que forma una unidad de sentido.También es una composición de caracteres imprimibles (con grafema) generados por un algoritmo de cifrado que, aunque no tienen sentido para cualquier persona, sí puede ser descifrado por su destinatario original. En otras palabras, un texto es un entramado de signos con una intención comunicativa que adquiere sentido en determinado contexto."
        cell.yearPeliculaLabe.text = "2016"
        
        return cell
    }

}
//MARK: Extension delegado
extension MoviesViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
