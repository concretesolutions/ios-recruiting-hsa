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
    @IBOutlet weak var imageError: UIImageView!
    @IBOutlet weak var labelError: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var filteredData:[DataResult]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ResponsePopularMovies.shared.results.count > 0 {
            filteredData = ResponsePopularMovies.shared.results
        }
        imageError.isHidden = true
        labelError.isHidden = true
        searchBar.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FavoritesViewController.dismissKeyboard))
                
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if ResponsePopularMovies.shared.results.count > 0 {
            llenarTabla()
        }
        else {
            mostrarError()
        }
    }
    
    @objc func dismissKeyboard() {
           view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ResponsePopularMovies.shared.results.count > 0 {
            return filteredData.count
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaALLMovies", for: indexPath) as! MoviesAllCell
        
        let URLimage = StructRequest.shared.getURLimage(cadenaFinalImagen: filteredData[indexPath.row].poster_path)
        let dateMovie = filteredData[indexPath.row].release_date
        
        cell.nombrePeliculaLabel.text = filteredData[indexPath.row].title
        cell.yearPeliculaLabe.text = String(dateMovie.prefix(4))
        cell.DescripcionTextView.text = filteredData[indexPath.row].overview
        cell.favoriteImage.isHidden = !FavoriteMovies.shared.validarFavorito(idValidar: filteredData[indexPath.row].id)
        
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
        
        tableMovies.isHidden = false
        imageError.isHidden = true
        labelError.isHidden = true
        
        tableMovies.dataSource = self
        tableMovies.delegate = self
        tableMovies.tableFooterView = UIView()
        tableMovies.register(UINib(nibName: "MoviesAllCell", bundle: nil), forCellReuseIdentifier: "CeldaALLMovies")

        tableMovies.reloadData()
    }
    
    func mostrarError(){
        
        tableMovies.isHidden = true
        imageError.isHidden = false
        labelError.isHidden = false
        labelError.text = "Se ha generado un error al consultar la información de películas"
    }

}
//MARK: Extension delegado
extension MoviesViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let idMovie = filteredData[indexPath.row].id
        let numCelda = ResponsePopularMovies.shared.obtenerIndicePelicula(id: idMovie)
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
//MARK: Extension delegado para barra de busqueda
extension MoviesViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText == ""
        {
            filteredData = ResponsePopularMovies.shared.results
        }
        
        for word in ResponsePopularMovies.shared.results
        {
            if word.title.uppercased().contains(searchText.uppercased())
            {
                filteredData.append(word)
            }
        }
        
        tableMovies.reloadData()
    }
}
