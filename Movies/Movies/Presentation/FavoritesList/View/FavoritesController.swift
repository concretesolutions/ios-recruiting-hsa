//
//  FavoritesController.swift
//  Movies
//
//  Created by Daniel Nunez on 03-03-21.
//

import UIKit

class FavoritesController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    weak var coordinator: MainCoordinator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
