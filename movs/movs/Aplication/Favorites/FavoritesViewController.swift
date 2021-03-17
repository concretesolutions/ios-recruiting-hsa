//
//  FavoritesViewController.swift
//  movs
//
//  Created by Carlos Petit on 15-03-21.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var filterFavoriteButton: UIButton!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    @IBAction func addTapped(_ sender: UIButton) {
        
    }
    private var viewModel = FavoritesMoviesViewModel ()
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(addTapped))
        
        self.navigationItem.title = "Movies"
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        
        self.favoritesTableView.delegate = self
        self.favoritesTableView.dataSource = self
        
        let cell = UINib(nibName: "FavoriteCell", bundle: .main)
        favoritesTableView.register(cell, forCellReuseIdentifier: "cellView")
        print(favItems.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    

}

extension FavoritesViewController: FavoritesMoviesViewModeldelegate{
    func reloadData() {
        favoritesTableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.remove(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      let contextItem = UIContextualAction(style: .destructive, title: "Unfavorite") { [weak self](contextualAction, view, boolValue) in
        self?.viewModel.remove(at: indexPath)
        tableView.deleteRows(at: [indexPath], with: .left)
      }
      let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

      return swipeActions
  }
}


extension FavoritesViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellView", for: indexPath) as? CellTableViewCell else {
            return UITableViewCell()
        }
        cell.setUp(with: viewModel.item(at: indexPath), indexPath: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.numbersOfItems
        tableView.separatorStyle = count == 0 ? .none : .singleLine
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
}
