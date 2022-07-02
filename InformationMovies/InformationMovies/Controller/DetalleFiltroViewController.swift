//
//  DetalleFiltroViewController.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 30-06-22.
//

import UIKit

class DetalleFiltroViewController: UIViewController {

    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var tablaFiltro: UITableView!
    
    var numFilaRecibido:Int?
    var years: Set<String> = []
    var yearAUX:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tituloPantalla()
        quitarFechaRepetida()
        tablaFiltro.dataSource = self
        tablaFiltro.delegate = self
    }
    @IBAction func onTapBackFilter(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func tituloPantalla(){
     
        if numFilaRecibido! == 0 {
            tituloLabel.text = "Año"
        }
        else
        {
            tituloLabel.text = "Genero"
        }
    }
    
    func quitarFechaRepetida(){
        
        ResponsePopularMovies.shared.results.forEach { result in
            let dateMovie = result.release_date
            let yearMovie = String(dateMovie.prefix(4))
            years.insert(yearMovie)
        }
        years.forEach { n in
            yearAUX.append(n)
        }
    }
    
}

//MARK: Extension data source
extension DetalleFiltroViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if numFilaRecibido! == 0 {
            return yearAUX.count
        }
        else
        {
            return ResponseCategories.shared.genres.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CeldaFiltro")
        
        if numFilaRecibido! == 0 {

            cell.textLabel?.text = yearAUX[indexPath.row]
        }
        else
        {
            cell.textLabel?.text = ResponseCategories.shared.genres[indexPath.row].name
        }
        
        return cell
    }
    
}

//MARK: Extension delegado
extension DetalleFiltroViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if numFilaRecibido! == 0 {
            let dateMovie = yearAUX[indexPath.row]
            FilterInfo.shared.yearSelected = dateMovie
            self.dismiss(animated: true)
        }
        else
        {
            FilterInfo.shared.categoriSelected = ResponseCategories.shared.genres[indexPath.row].name
            self.dismiss(animated: true)
        }
    }
}
