//
//  FavoritesViewController.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 25-06-22.
//

import UIKit
import Alamofire
import AlamofireImage

class FavoritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableMovies: UITableView!
    var items:[EntidadNumeroFila]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tableMovies.dataSource = self
        tableMovies.delegate = self
        tableMovies.tableFooterView = UIView()
        tableMovies.register(UINib(nibName: "MoviesAllCell", bundle: nil), forCellReuseIdentifier: "CeldaALLMovies")
        tableMovies.reloadData()
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteMovies.shared.favoriteMoviesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        do { self.items = try context.fetch(EntidadNumeroFila.fetchRequest())}
        catch{}
        
        let accionEliminar = UIContextualAction(style: .destructive, title: "Eliminar") { (action,view, completionHandler) in
            
            let itemEliminar = self.items![indexPath.row]
            FavoriteMovies.shared.quitarFavorito(posIndex: indexPath.row)
            self.deletePersistItem(item: itemEliminar)
            self.tableMovies.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [accionEliminar])
    }
    /* FUNCIONA OK
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 
        if editingStyle == .delete {
   
            do { self.items = try context.fetch(EntidadNumeroFila.fetchRequest()) }
            catch{}

                let itemEliminar = self.items![indexPath.row]
                FavoriteMovies.shared.quitarFavorito(posIndex: indexPath.row)
                self.deletePersistItem(item: itemEliminar)
            
            tableMovies.reloadData()
        
        }
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaALLMovies", for: indexPath) as! MoviesAllCell
        let URLimage = StructRequest.shared.getURLimage(cadenaFinalImagen: FavoriteMovies.shared.favoriteMoviesArray[indexPath.row].poster_path)
        let dateMovie = FavoriteMovies.shared.favoriteMoviesArray[indexPath.row].release_date
        
        cell.nombrePeliculaLabel.text = FavoriteMovies.shared.favoriteMoviesArray[indexPath.row].title
        cell.yearPeliculaLabe.text = String(dateMovie.prefix(4))
        cell.DescripcionTextView.text = FavoriteMovies.shared.favoriteMoviesArray[indexPath.row].overview
        
        AF.request(URLimage).responseImage {
            
            respuesta in
            if case .success(let image)=respuesta.result {
                
                cell.imagenPeliculaImage.image=image
                cell.imagenPeliculaImage.contentMode = .scaleToFill
            }
            
        }
        
        return cell
    }
    
    func deletePersistItem(item:EntidadNumeroFila){
        
        context.delete(item)
        
        do { try context.save()}
        catch {}
    }

}
