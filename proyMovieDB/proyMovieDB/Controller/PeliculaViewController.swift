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

    var detallesPelicula = DetallePelicula()
    var rqApi = Requests()
    var flExiste: Bool = true
    
    override func viewDidLoad() {
        let urlImagen = rqApi.obtenerImagenPeli(urlImagen: detallesPelicula.urlImagenAmpliada)
        super.viewDidLoad()
        nombrePeliculaLabel.text = detallesPelicula.titulo
        anioPeliculaLabel.text = detallesPelicula.anio
        descripcionPelicula.text = detallesPelicula.descripcion
        generoPeliculaLabel.text = detallesPelicula.genero.formatted()
        
        AF.request(urlImagen).responseImage {respuesta in
            if case .success(let imagen) = respuesta.result {
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
    
    @IBAction func onVueltaPeliculas(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func onPresionarFavorito(_ sender: Any) {
        var flEliminar: Bool = false
        let btnImage = UIImage(named: "favorite_full_icon.png")
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
    }
}
