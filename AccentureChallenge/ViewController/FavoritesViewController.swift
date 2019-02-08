//
//  FavoritesViewController.swift
//  AccentureChallenge
//
//  Created by Jaime on 2/4/19.
//  Copyright © 2019 Jaime. All rights reserved.
//

import UIKit
import RealmSwift
import ActionSheetPicker_3_0

class FavoritesViewController: BaseViewController {

    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet weak var deleteBlurVisualEffectView: UIVisualEffectView!
    
    var movies: Results<Movie>!
    var filteredMovies: [Movie]!
    
    enum SelectedFilter {
        case year
        case genre
    }
    
    //var selectedFilter: SelectedFilter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        
        let blurViewTap = UITapGestureRecognizer(target: self, action: #selector(self.blurViewTap(_:)))
        deleteBlurVisualEffectView.addGestureRecognizer(blurViewTap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        movies = realm.objects(Movie.self).filter("isFavorite == true")
        filteredMovies = Array(movies)
        favoritesTableView.reloadData()
        deleteBlurVisualEffectView.isHidden = true
    }
    
    @objc func blurViewTap(_ sender: UITapGestureRecognizer) {
        
        deleteBlurVisualEffectView.isHidden = true
        filteredMovies = Array(movies)
        favoritesTableView.reloadData()
        
    }
    
    func presentYearPicker() {
        
        let years = Array(1900...2019)
        
        let yearPicker = ActionSheetStringPicker(title: "Año", rows: years, initialSelection: years.count-1, doneBlock: { (picker, index, value) in
            
            let selectedYear = "\(years[index])"
            var tempMovies = [Movie]()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy"
            
            for element in self.movies {
                
                if selectedYear == dateFormatter.string(from: element.date){
                    
                    tempMovies.append(element)
                    
                }
            }
            
            self.filteredMovies = tempMovies
            self.favoritesTableView.reloadData()
            self.deleteBlurVisualEffectView.isHidden = false
            
        }, cancel: nil, origin: self.view)
        
        yearPicker?.show()
        
    }
    
    func presentGenrePicker() {
        
        let genres = realm.objects(Genre.self)
        var genresNames = [String]()
        
        for element in genres {
            
            genresNames.append(element.name)
        }
        
        let genrePicker = ActionSheetStringPicker(title: "Género", rows: genresNames, initialSelection: 0, doneBlock: { (picker, index, value) in
            
            let selectedGenre = genres[index]
            var tempMovies = [Movie]()
            
            for element in self.movies {
                
                if element.genres.contains(selectedGenre) {
                    
                    tempMovies.append(element)
                    
                }
            }
            
            self.filteredMovies = tempMovies
            self.favoritesTableView.reloadData()
            self.deleteBlurVisualEffectView.isHidden = false
            
        }, cancel: nil, origin: self.view)
        
        genrePicker?.show()
        
    }
    
    @IBAction func filterTap(_ sender: Any) {
        
        let myActionSheet = UIAlertController(title: "Filtrar", message: "Seleccione un filtro.", preferredStyle: UIAlertController.Style.actionSheet)
        
        let yearFilterAction = UIAlertAction(title: "Año", style: UIAlertAction.Style.default) { (action) in
            self.presentYearPicker()
        }
        
        let genreFilterAction = UIAlertAction(title: "Género", style: UIAlertAction.Style.default) { (action) in
            self.presentGenrePicker()
        }

        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertAction.Style.cancel) { (action) in
  
        }
        
        myActionSheet.addAction(yearFilterAction)
        myActionSheet.addAction(genreFilterAction)
        myActionSheet.addAction(cancelAction)
        self.present(myActionSheet, animated: true, completion: nil)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredMovies.count >= 1 {
            
            return filteredMovies.count

        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if filteredMovies.count >= 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! FavoriteTableViewCell
            cell.movie = filteredMovies[indexPath.row]
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath)
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            try! realm.write {
                
                filteredMovies[indexPath.row].isFavorite = false
                
            }
            
            filteredMovies.remove(at: indexPath.row)
            
            if filteredMovies.count == 0 {
                
                tableView.reloadData()
                
            } else {
                
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            }
        }
    }
}
