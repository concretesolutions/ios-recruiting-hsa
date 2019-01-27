//
//  FavoriteViewController.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 24/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit
class FavoriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    

    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var removeFilterButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
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
        
        removeFilterButton.isHidden = true
        removeFilterButton.titleLabel?.text = "Remove Filter"
        removeFilterButton.setTitle("Remove Filter", for: .normal)
        Tools.sharedInstance.styleButtonRemove(button: removeFilterButton)
        removeFilterButton.addTarget(self, action: #selector(removeFilterPressed), for: .touchUpInside)
        
        self.navigationController?.navigationBar.topItem?.title = "Movies"
        self.navigationController?.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideRemoveFilterButton()
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
        cell.delegate = self
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
    
    func showRemoveFilterButton() {
        self.heightConstraint.constant = 50
        self.removeFilterButton.isHidden = false
    }
    
    func hideRemoveFilterButton() {
        heightConstraint.constant = 0
        removeFilterButton.isHidden = true
        searchBar.text = ""
    }
    
    //MARK: - Actions
    @objc func removeFilterPressed(sender : UIButton) {
        searchBar.text = ""
        hideRemoveFilterButton()
        loadMovies()
    }
    
    
    //MARK: - SearchBar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        if searchBar.text?.count == 0 {
            hideRemoveFilterButton()
            loadMovies()
            return
        }
        
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        
        showRemoveFilterButton()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        
        let sortDescription = NSSortDescriptor(key: "id", ascending: true)
        request.sortDescriptors = [sortDescription]
        
        loadMovies(with: request)
        //searchBar.resignFirstResponder()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadMovies()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
        
    }

}

extension FavoriteViewController : SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Unfavorite") { action, indexPath in
            // handle action by updating model with deletion
            self.context.delete(self.list[indexPath.row])
            self.list.remove(at: indexPath.row)
            
            do {
                try self.context.save()
                self.movieTableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("Error saving context \(error)")
            }
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
}
