//
//  PeliculasViewController.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 30-05-23.
//

import UIKit
import Alamofire
import AlamofireImage

class PeliculasViewController: UIViewController {

    @IBOutlet weak var peliculasPopularesCollectionView: UICollectionView!
  
    var rqApi = Requests()
    var pelicula = PeliculaViewController()
    var consumirAPI = ConsumirAPI()
    var detallePeli = DetallePelicula()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peliculasPopularesCollectionView.dataSource = self
        peliculasPopularesCollectionView.delegate = self
        peliculasPopularesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        peliculasPopularesCollectionView.reloadData()
    }
}

extension PeliculasViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ResponsesPelisPopulares.shared.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var flEsFavorita: Bool = false
        let celda = collectionView.dequeueReusableCell(withReuseIdentifier: "PeliculasPopularesCollectionViewCell", for: indexPath) as! PeliculasPopularesCollectionViewCell
        celda.llenar(peli: ResponsesPelisPopulares.shared.results[indexPath.row])
        let urlImagen = rqApi.obtenerImagenPeli(urlImagen: ResponsesPelisPopulares.shared.results[indexPath.row].poster_path)
        
        AF.request(urlImagen).responseImage {respuesta in
            if case .success(let imagen) = respuesta.result {
                celda.imagenPeliculaView.image = imagen
                celda.imagenPeliculaView.contentMode = .scaleToFill
            }
        }
        
        Favoritos.shared.peliculaFav.forEach { detallePeli in
        if detallePeli.id  == ResponsesPelisPopulares.shared.results[indexPath.row].id {
            flEsFavorita = true
            }
        }
        
        if flEsFavorita {
            celda.iconoFavoritoMarcado.isHidden = false
        } else {
            celda.iconoFavoritoMarcado.isHidden = true
        }
        return celda
    }
}

//ajusta tamaño de la celda
extension PeliculasViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 280)
    }
}

//acción al seleccionar la celda
extension PeliculasViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var listaNombresGen: [String] = []
        
        ResponsesPelisPopulares.shared.results[indexPath.row].genre_ids.forEach { generoBuscado in
            ResponseGeneros.shared.genres.forEach { generoGuardado in
                if generoGuardado.id == generoBuscado {
                    listaNombresGen.append(generoGuardado.name)
                }
            }
        }
        detallePeli.genero = listaNombresGen
        let anio = ResponsesPelisPopulares.shared.results[indexPath.row].release_date
        detallePeli.anio = String(anio.prefix(4))
        detallePeli.titulo = ResponsesPelisPopulares.shared.results[indexPath.row].title
        detallePeli.urlImagenAmpliada = rqApi.obtenerImagenPeli(urlImagen: ResponsesPelisPopulares.shared.results[indexPath.row].backdrop_path)
        detallePeli.urlImagenPoster = rqApi.obtenerImagenPeli(urlImagen: ResponsesPelisPopulares.shared.results[indexPath.row].poster_path)
        detallePeli.descripcion = ResponsesPelisPopulares.shared.results[indexPath.row].overview
        detallePeli.id = ResponsesPelisPopulares.shared.results[indexPath.row].id
        self.performSegue(withIdentifier: "DetallePeliculaSegue", sender: detallePeli)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetallePeliculaSegue" {
            let viewControllerDestino = segue.destination as? PeliculaViewController
            viewControllerDestino?.detallesPelicula = detallePeli
        }
    }
}
