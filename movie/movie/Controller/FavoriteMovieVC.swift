//
//  FavoriteMovieVC.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 24/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class FavoriteMovieVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var favoriteTableView: UITableView!
    
    var movies: [MovieEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        favoriteTableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if movies.count >= 1 {
                    favoriteTableView.isHidden = false
                } else {
                    favoriteTableView.isHidden = true
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Tab Favorite")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMovieCell") as? FavoriteMovieCell else { return UITableViewCell() }
        let movie = movies[indexPath.row]
        cell.configureCell(movie: movie)
        return cell
    }

    @IBAction func moviesBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
}

extension FavoriteMovieVC{
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        
        do {
            movies = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}
