//
//  ViewController.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 24-06-22.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieSelectedViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[EntidadNumeroFila]?

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var tituloPeliculaLabel: UILabel!
    @IBOutlet weak var yearPeliculaLabel: UILabel!
    @IBOutlet weak var categoriaLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var imageFavoriteFULL: UIImageView!
    
    var numFilaRecibido:Int?
    var nombreCategorias:[String] = []
    var idCategorias:[Int] = []
    var categorias:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idCategorias = ResponsePopularMovies.shared.results[numFilaRecibido ?? 0].genre_ids
        categorias = buscarCategoria()
        cargarInfoPantalla()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //imageFavoriteFULL.isHidden = true
    }

    @IBAction func onTapBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func onTapFavoriteButton(_ sender: Any) {
        
        let idPelicula = ResponsePopularMovies.shared.results[numFilaRecibido ?? 0].id
        
        if imageFavoriteFULL.isHidden {
            
            imageFavoriteFULL.isHidden = false
            FavoriteMovies.shared.agregarFavorito(datos: ResponsePopularMovies.shared.results[numFilaRecibido ?? 0])
            createPersistItem(id: idPelicula)
            
            alertaRegistroSatisfactorio(tituloAlerta: "Favorito Creado", mensaje: "Su película ha sido guardada como favorita correctamente")
        }
        else
        {
            imageFavoriteFULL.isHidden = true
            let idPelicula = ResponsePopularMovies.shared.results[numFilaRecibido ?? 0].id
            let pos = FavoriteMovies.shared.obtenerIndiceFavorito(id: idPelicula)
            
            do { self.items = try context.fetch(EntidadNumeroFila.fetchRequest())}
            catch{}
            
            items?.forEach({ item in
                if item.idMovie == idPelicula {
                    print(item.idMovie)
                    self.deletePersistItem(item: item)
                }
            })
           FavoriteMovies.shared.quitarFavorito(posIndex: pos)
           alertaAviso(tituloAlerta: "Favorito Eliminado", mensaje: "Su película ha sido retirada de la lista de favoritos")
        }

    }
    
    func cargarInfoPantalla(){
        
        let idEvaluar = ResponsePopularMovies.shared.results[numFilaRecibido ?? 0].id
        
        if FavoriteMovies.shared.validarFavorito(idValidar: idEvaluar) == true
        {
            imageFavoriteFULL.isHidden = false
        }
        else
        {
            imageFavoriteFULL.isHidden = true
        }
        
        let dateMovie = ResponsePopularMovies.shared.results[numFilaRecibido ?? 0].release_date
        tituloPeliculaLabel.text = ResponsePopularMovies.shared.results[numFilaRecibido ?? 0].title
        yearPeliculaLabel.text = String(dateMovie.prefix(4))
        categoriaLabel.text = categorias
        descriptionTextView.text = ResponsePopularMovies.shared.results[numFilaRecibido ?? 0].overview
        let URLimage = StructRequest.shared.getURLimage(cadenaFinalImagen: ResponsePopularMovies.shared.results[numFilaRecibido ?? 0].backdrop_path)
        
        AF.request(URLimage).responseImage {
            
            respuesta in
            if case .success(let image)=respuesta.result {
                
                self.imageMovie.image = image
                self.imageMovie.contentMode = .scaleToFill
  
            }
        }
        
    }
    
    func buscarCategoria() -> String
    {
        var nombreCategoriasAUX:String = String()
        idCategorias.forEach { catPelicula in
            ResponseCategories.shared.genres.forEach { categorias in
                
                if catPelicula == categorias.id
                {
                    nombreCategorias.append(categorias.name)
                }
            }
        }
        nombreCategorias.forEach { cat in
            nombreCategoriasAUX += cat + ","
        }
        let retorno = String(nombreCategoriasAUX.dropLast())
        return retorno
    }
    
    func createPersistItem(id:Int){
        
        let newItem = EntidadNumeroFila(context: context)
        newItem.idMovie = Int64(id)
        
        do { try context.save() }
        catch {}
    }
    
    func deletePersistItem(item:EntidadNumeroFila){
        
        context.delete(item)
        
        do { try context.save()}
        catch {}
    }
    
    func alertaAviso (tituloAlerta:String, mensaje:String)
    {
        let alert = UIAlertController(title: tituloAlerta, message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Entendido", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert,animated: true, completion: nil)
    }
    
    func alertaRegistroSatisfactorio(tituloAlerta:String, mensaje:String)
    {
        let alert = UIAlertController(title: tituloAlerta, message: mensaje, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Entendido", style: .default) { _ in
            
            //self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true)

        }
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
}

