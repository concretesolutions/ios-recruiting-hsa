//
//  MoviesViewController.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 25-06-22.
//

import UIKit
import Alamofire
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableMovies: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        llenarTabla()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ResponsePopularMovies.shared.results.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaALLMovies", for: indexPath) as! MoviesAllCell
        let URLimage = StructRequest.shared.getURLimage(cadenaFinalImagen: ResponsePopularMovies.shared.results[indexPath.row].poster_path)
        let dateMovie = ResponsePopularMovies.shared.results[indexPath.row].release_date
        
        cell.nombrePeliculaLabel.text = ResponsePopularMovies.shared.results[indexPath.row].title
        cell.yearPeliculaLabe.text = String(dateMovie.prefix(4))
        cell.DescripcionTextView.text = ResponsePopularMovies.shared.results[indexPath.row].overview
        
        AF.request(URLimage).responseImage {
            
            respuesta in
            if case .success(let image)=respuesta.result {
                
                cell.imagenPeliculaImage.image=image
                cell.imagenPeliculaImage.contentMode = .scaleToFill
            }
            
        }
        
        return cell
    }

    func llenarTabla() {
        
        tableMovies.dataSource = self
        tableMovies.delegate = self
        tableMovies.tableFooterView = UIView()
        tableMovies.register(UINib(nibName: "MoviesAllCell", bundle: nil), forCellReuseIdentifier: "CeldaALLMovies")

        tableMovies.reloadData()
    }

}
//MARK: Extension delegado
extension MoviesViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let numCelda = indexPath.row
        self.performSegue(withIdentifier: "PantallaDetallePelicula", sender: numCelda)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PantallaDetallePelicula"
        {
            let numRecibido = sender as! Int
            let objSiguientePantalla:MovieSelectedViewController = segue.destination as! MovieSelectedViewController
            
            objSiguientePantalla.numFilaRecibido = numRecibido
        }
    }
}
