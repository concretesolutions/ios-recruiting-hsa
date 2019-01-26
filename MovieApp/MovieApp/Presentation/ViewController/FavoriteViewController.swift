//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 24/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    

    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var list = [MovieEntity]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        searchBar.delegate = self
        searchBar.isTranslucent = true
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = Tools.sharedInstance.getYelloAppColor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        callMoviesFromDataBase()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieTableViewCell") as! FavoriteMovieTableViewCell
        
        let movieEntity = list[indexPath.row]
        cell.setupMovieCell(imageUrl: movieEntity.image!, title: movieEntity.title!, year: "2018", description: movieEntity.overview ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    //MARK: - Private
    func callMoviesFromDataBase() {
        loadMovies()
    }
    
    func loadMovies(with request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()) {
        do {
            list = try context.fetch(request)
        } catch {
            print("Error fetching data \(error)")
        }
        movieTableView.reloadData()
    }
    
    
    //MARK: - SearchBar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        if searchBar.text?.count == 0 {
            loadMovies()
            return
        }
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        
        let sortDescription = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescription]
        
        loadMovies(with: request)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
        
    }
    
    

}
