//
//  FavoritosViewController.swift
//  TestProject
//
//  Created by Felipe S Vergara on 20-10-18.
//  Copyright © 2018 MyOwnCompany. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyPlaceholderView: UIView!
    
    //Presenter 
    var presenter: FavoritesPresenter?
    //Favorite List
    var favoriteList:[Movie] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor.init(named: ColorName.DeepBlue.rawValue)
        self.emptyPlaceholderView.backgroundColor = UIColor.init(named: ColorName.DeepBlue.rawValue)
        self.navigationController?.setUpForApplication()
        
        //RightButton
        /*
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "filter"), style: .done, target: self, action: #selector(FavoritesViewController.filter))
        rightBarButtonItem.tintColor = .white
        self.navigationItem.rightBarButtonItem = rightBarButtonItem*/
       
        //init presenter
        self.presenter = FavoritesPresenter(delegate: self)
        
    }
    
    
    @objc func filter(){
        print("Under construction...")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Every time we enter to the view, we load favorites.
        self.presenter?.loadFavorites()
    }
    
    func checkEmptyData(){
        //Check Filter Movies
        self.emptyPlaceholderView.isHidden = self.favoriteList.count == 0 ? false : true
    }

}


//MARK: - TableView Delegates
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        checkEmptyData()
        return self.favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        cell.favorite = self.favoriteList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.presenter?.removeFavorite(movie: self.favoriteList[indexPath.row])
        }
    }
    
}


//MARK: - Response from PRESENTER to VIEW
extension FavoritesViewController: FavoriteEventReponse{
    func favoriteRemoved(favorites: [Movie]) {
        self.favoriteList = favorites
        self.tableView.reloadData()
    }
    
    func favoritesLoaded(favorites: [Movie]) {
        self.favoriteList = favorites
        self.tableView.reloadData()
    }
}
