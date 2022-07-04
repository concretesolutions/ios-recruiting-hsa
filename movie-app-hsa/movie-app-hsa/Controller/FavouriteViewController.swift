//
//  FavouriteViewController.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let favouriteManager = FavouriteManager.shared
    
    var favoriteList: [Favourite] = []
    
    @IBOutlet weak var favouriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

    func setup() {
        favoriteList = favouriteManager.setToArray()
        favouriteManager.lists()
        favouriteTableView.dataSource = self
        favouriteTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        favouriteManager.lists()
        favoriteList = favouriteManager.setToArray()
        
        favouriteTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouriteManager.count()
 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favouriteCell:FavouriteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteTableViewCell
        
        print(favoriteList)
        print(indexPath.row)
        
        favouriteCell.id = favoriteList[indexPath.row].id
        favouriteCell.name = favoriteList[indexPath.row].name
        favouriteCell.releaseDate = favoriteList[indexPath.row].releaseDate
        favouriteCell.synopsis = favoriteList[indexPath.row].synopsis
        favouriteCell.image = favoriteList[indexPath.row].image
        
        favouriteCell.nameLabel.text = favoriteList[indexPath.row].name
        favouriteCell.yearReleaseLabel.text = favoriteList[indexPath.row].releaseDate
        favouriteCell.synopsisLabel.text = favoriteList[indexPath.row].synopsis
        
        if let urlImage = URL(string: favoriteList[indexPath.row].image) {
            favouriteCell.movieImageView.load(url: urlImage)
        }
        return favouriteCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("delete")
            
            let favourite: Favourite = Favourite(id: favoriteList[indexPath.row].id, name: favoriteList[indexPath.row].name, image: favoriteList[indexPath.row].image, releaseDate: favoriteList[indexPath.row].releaseDate, synopsis: favoriteList[indexPath.row].synopsis)
            favouriteManager.remove(favourite: favourite)
            
            favouriteManager.remove(favourite: favourite)
            
            favoriteList = favouriteManager.setToArray()
            favouriteManager.lists()
            favouriteTableView.reloadData()
        }
    }
}
