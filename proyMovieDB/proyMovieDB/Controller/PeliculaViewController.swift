//
//  PeliculaViewController.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 06-06-23.
//

import UIKit
import Alamofire
import AlamofireImage

class PeliculaViewController: UIViewController {

    @IBOutlet weak var posterPeliculaImageView: UIImageView!
    @IBOutlet weak var nombrePeliculaLabel: UILabel!
    @IBOutlet weak var anioPeliculaLabel: UILabel!
    @IBOutlet weak var generoPeliculaLabel: UILabel!
    @IBOutlet weak var descripcionPelicula: UITextView!
    @IBOutlet weak var favoritosButton: UIButton!
    @IBOutlet weak var favoritosImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cargaSpinner: UIActivityIndicatorView!
    
    var detallesPelicula = DetallePelicula()
    var rqApi = Requests()
    var flExiste: Bool = true
    var idPelicula:[Int] = []
    
    override func viewDidLoad() {
     
        cargaSpinner.startAnimating()
        let urlImagen = rqApi.obtenerImagenPeli(urlImagen: detallesPelicula.urlImagenAmpliada)
        super.viewDidLoad()
        
        nombrePeliculaLabel.text = detallesPelicula.titulo
        anioPeliculaLabel.text = detallesPelicula.anio
        descripcionPelicula.text = detallesPelicula.descripcion
        generoPeliculaLabel.text = detallesPelicula.genero.formatted()
        
        AF.request(urlImagen).responseImage {respuesta in
            if case .success(let imagen) = respuesta.result {
                self.cargaSpinner.stopAnimating()
                self.cargaSpinner.hidesWhenStopped = true
                self.posterPeliculaImageView.image = imagen
                self.posterPeliculaImageView.contentMode = .scaleToFill
            }
        }
        
        Favoritos.shared.peliculaFav.forEach { peliFav in
            if peliFav.id == detallesPelicula.id {
                favoritosImage.isHidden = false
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let idPeliculasPersistentes:[Int] = UserDefaults.standard.object(forKey: "keyID") as? [Int] {
            idPeliculasPersistentes.forEach { id in
                idPelicula.append(id)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        UserDefaults.standard.set(idPelicula, forKey: "keyID")
        UserDefaults.standard.synchronize()
    }
    
    func agregarIdPelicula() {
        
        var agregar:Bool = true
        
        idPelicula.forEach { pelicula in
            Favoritos.shared.peliculaFav.forEach { peliculaShared in
                if pelicula == peliculaShared.id {
                    agregar = false
                } else {
                    agregar = true
                }
            }
        }
        
        if agregar {
            idPelicula.append(detallesPelicula.id)
        }
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
    
    @IBAction func onVueltaPeliculas(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func onPresionarFavorito(_ sender: Any) {
      
        var flEliminar: Bool = false

        if Favoritos.shared.peliculaFav.isEmpty {
            Favoritos.shared.peliculaFav.append(detallesPelicula)
            favoritosImage.isHidden = false
        } else {
            Favoritos.shared.peliculaFav.forEach { peliFav in
                if peliFav.id == detallesPelicula.id {
                    let indexV = Favoritos.shared.peliculaFav.firstIndex(of: peliFav)
                    guard let indiceDestapado = indexV else {
                       return
                    }
                    Favoritos.shared.peliculaFav.remove(at: indiceDestapado)
                    eliminarIdPelicula(idPeli: detallesPelicula.id)
                    flEliminar = true
                    favoritosImage.isHidden = true
                    return
                }
            }
            
            if !flEliminar {
                Favoritos.shared.peliculaFav.append(detallesPelicula)
                favoritosImage.isHidden = false
            }
        }
        agregarIdPelicula()
    }
}
