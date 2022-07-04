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
    @IBOutlet weak var alertImage: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var quitarFiltroButton: UIButton!
    
    var items:[EntidadNumeroFila]?
    var filteredData:[DataResult]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if FavoriteMovies.shared.favoriteMoviesArray.count > 0 {
            filteredData = FavoriteMovies.shared.favoriteMoviesArray
        }
        alertImage.isHidden = true
        alertLabel.isHidden = true
        searchBar.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FavoritesViewController.dismissKeyboard))
                
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if FavoriteMovies.shared.favoriteMoviesArray.count > 0 {

            alertImage.isHidden = true
            alertLabel.isHidden = true
            llenarTabla()
        }
        else
        {
            alertImage.image = UIImage(named : "attention")
            alertLabel.text = "Usted no ha marcado ninguna película como favorito"
            alertImage.isHidden = false
            alertLabel.isHidden = false
        }
        
        let idCategoria = ResponseCategories.shared.getIDCategory(name: FilterInfo.shared.categoriSelected)
                
        aplicarFiltroGenereYear(aplicarFiltroAnio: FilterInfo.shared.applyYear, year: FilterInfo.shared.yearSelected, aplicarFiltroGenero: FilterInfo.shared.applyCategory, genero: idCategoria)
        
        searchBar.text = ""
    }
    
    @objc func dismissKeyboard() {
           view.endEditing(true)
    }
    
    func buscarPosicionPersistItems(id:Int) -> Int {
        
        var respuesta:Int = 0
        items!.forEach { dato in
            if dato.idMovie == id {
                if let idX = items!.firstIndex(of: dato){
                    respuesta = idX
                }
            }
        }
        return respuesta
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredData.count == 0 && FavoriteMovies.shared.favoriteMoviesArray.count > 0
        {
            alertImage.isHidden = false
            alertLabel.isHidden = false
            alertImage.image = UIImage(named: "magnifying-glass") //search_icon
            alertLabel.text = "Ningún resultado coincide con tu búsqueda 😟"
        }
        else if filteredData.count == 0 && FavoriteMovies.shared.favoriteMoviesArray.count == 0
        {
            alertImage.isHidden = false
            alertLabel.isHidden = false
            alertImage.image = UIImage(named : "attention")
            alertLabel.text = "Usted no ha marcado ninguna película como favorita"
        }
        else
        {
            alertImage.isHidden = true
            alertLabel.isHidden = true
            alertLabel.text = "Usted no ha marcado ninguna película como favorita"
        }
        
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        do { self.items = try context.fetch(EntidadNumeroFila.fetchRequest())}
        catch{}
        
        let accionEliminar = UIContextualAction(style: .destructive, title: "Eliminar") { (action,view, completionHandler) in
            
            let idMovie = self.filteredData[indexPath.row].id
            let posDelete = self.buscarPosicionPersistItems(id: idMovie)
            let itemEliminar = self.items![posDelete]

            FavoriteMovies.shared.quitarFavoritoPorID(pID: idMovie)
            
            self.filteredData.remove(at: indexPath.row)
            self.deletePersistItem(item: itemEliminar)
            self.tableMovies.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [accionEliminar])
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CeldaALLMovies", for: indexPath) as! MoviesAllCell
        let URLimage = StructRequest.shared.getURLimage(cadenaFinalImagen: filteredData[indexPath.row].poster_path)
        let dateMovie = filteredData[indexPath.row].release_date
        
        cell.nombrePeliculaLabel.text = filteredData[indexPath.row].title
        cell.yearPeliculaLabe.text = String(dateMovie.prefix(4))
        cell.DescripcionTextView.text = filteredData[indexPath.row].overview
        
        cell.favoriteImage.isHidden = true
        
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
    
    func llenarTabla() {
        
        tableMovies.dataSource = self
        tableMovies.delegate = self
        tableMovies.tableFooterView = UIView()
        tableMovies.register(UINib(nibName: "MoviesAllCell", bundle: nil), forCellReuseIdentifier: "CeldaALLMovies")

        tableMovies.reloadData()

    }
    @IBAction func onTapQuitarFiltro(_ sender: Any) {
        
        filteredData = FavoriteMovies.shared.favoriteMoviesArray
        tableMovies.reloadData()
        quitarFiltroButton.isHidden = true
        FilterInfo.shared.applyCategory = false
        FilterInfo.shared.applyYear = false
        FilterInfo.shared.categoriSelected = String()
        FilterInfo.shared.yearSelected = String()
        FilterInfo.shared.itemsFilter[0] = "Año"
        FilterInfo.shared.itemsFilter[1] = "Género"
    }
    
}

//MARK: Extension delegado para barra de busqueda
extension FavoritesViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
 
        if FilterInfo.shared.applyYear || FilterInfo.shared.applyCategory
        {
            
            var filteredAUX:[DataResult]!
            filteredAUX = filteredData
            
            filteredData = []
            
            if searchText == String()
            {
                //filteredData = filteredAUX
                let idCategoria = ResponseCategories.shared.getIDCategory(name: FilterInfo.shared.categoriSelected)
                        
                aplicarFiltroGenereYear(aplicarFiltroAnio: FilterInfo.shared.applyYear, year: FilterInfo.shared.yearSelected, aplicarFiltroGenero: FilterInfo.shared.applyCategory, genero: idCategoria)
            }
            else
            {
                for item in filteredAUX
                {
                    if item.title.uppercased().contains(searchText.uppercased())
                    {
                        filteredData.append(item)
                        
                    }
                }
            }
            
            tableMovies.reloadData()
        }
        else
        {
            filteredData = []
            if searchText == String()
            {
                filteredData = FavoriteMovies.shared.favoriteMoviesArray
            }
            for item in FavoriteMovies.shared.favoriteMoviesArray
            {
                if item.title.uppercased().contains(searchText.uppercased())
                {
                    filteredData.append(item)
                }
            }
            tableMovies.reloadData()
        }
    }
    
    func aplicarFiltroGenereYear(aplicarFiltroAnio:Bool, year:String, aplicarFiltroGenero:Bool, genero:Int){
        
        filteredData = []
        
        for item in FavoriteMovies.shared.favoriteMoviesArray
        {
            if aplicarFiltroAnio || aplicarFiltroGenero
            {
                quitarFiltroButton.isHidden = false
                
                if aplicarFiltroAnio && aplicarFiltroGenero == false
                {
                    if item.release_date.contains(year)
                    {
                        filteredData.append(item)
                    }
                }
                
                else if aplicarFiltroAnio == false && aplicarFiltroGenero
                {
                    if item.genre_ids.contains(genero)
                    {
                        filteredData.append(item)
                    }
                }
                
                else if aplicarFiltroAnio && aplicarFiltroGenero
                {
                    if item.release_date.contains(year) && item.genre_ids.contains(genero)
                    {
                        filteredData.append(item)
                    }
                }
            }
            else
            {
                quitarFiltroButton.isHidden = true
                filteredData = FavoriteMovies.shared.favoriteMoviesArray
            }
            
            tableMovies.reloadData()
        }
    }
}
