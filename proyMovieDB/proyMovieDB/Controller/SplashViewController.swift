//
//  SplashViewController.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 29-05-23.
//

import UIKit

class SplashViewController: UIViewController {

    var consumirAPI = ConsumirAPI()

    @IBOutlet weak var cargaSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        cargaSpinner.startAnimating()
        consumirAPI.obtenerListadoPeliculasPopulares()
        consumirAPI.obtenerGeneros()
        //Si se quiere limpiar completa la persistencia, ejecutar la siguiente funcion con TRUE
        limpiarPersistencia(limpiar: false)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3){
            self.obtenerPeliculasPersistentes()
            self.performSegue(withIdentifier: "GoHome", sender: nil)
        }
    }
    
    func obtenerPeliculasPersistentes() {
        
        var listaNombresGen: [String] = []
        var urlImagenAmpliada = ""
        var urlImagenPoster = ""
        let rqApi = Requests()
        
        if let idPeliculas:[Int] = UserDefaults.standard.object(forKey: "keyID") as? [Int] {
            idPeliculas.forEach { id in
                ResponsesPelisPopulares.shared.results.forEach { pelicula in
                    if id == pelicula.id {
                        pelicula.genre_ids.forEach { generoBuscado in
                            ResponseGeneros.shared.genres.forEach { generoGuardado in
                                if generoGuardado.id == generoBuscado {
                                    listaNombresGen.append(generoGuardado.name)
                                }
                            }
                        }
                        urlImagenAmpliada = rqApi.obtenerImagenPeli(urlImagen: pelicula.backdrop_path)
                        urlImagenPoster = rqApi.obtenerImagenPeli(urlImagen: pelicula.poster_path)
                        Favoritos.shared.peliculaFav.append(DetallePelicula(genero: listaNombresGen,
                                                                            anio: String(pelicula.release_date.prefix(4)),
                                                                            titulo: pelicula.title,
                                                                            descripcion: pelicula.overview,
                                                                            id: pelicula.id,
                                                                            urlImagenAmpliada: urlImagenAmpliada,
                                                                            urlImagenPoster: urlImagenPoster))
                        listaNombresGen = []
                    }
                }
            }
        } else {
            print("Datos no recuperados")
        }
    }
    
    func limpiarPersistencia(limpiar:Bool) {
        if limpiar {
            UserDefaults.standard.removeObject(forKey: "keyID")
            UserDefaults.standard.synchronize()
        }
    }
}
