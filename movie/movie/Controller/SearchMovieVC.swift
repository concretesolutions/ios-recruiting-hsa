//
//  ViewController.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 22/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class SearchMovieVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var movieCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        movieCollection.delegate = self
        movieCollection.dataSource = self
        
        MovieServices.instance.findAllMovies { (success,errorMessage) in
            if success{
                print("Puxou")
                self.movieCollection.reloadData()
            }
            else{
                let message = errorMessage
                print(message)
                self.EmptyTextField(text: "Pay Atention", message: message)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("rows",MovieServices.instance.movies.count)
        return MovieServices.instance.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCell {
            let movie = MovieServices.instance.movies[indexPath.row]
            cell.configureCell(movie: movie)
            return cell
        }
//
        return MovieCell()
    }
    
    
    func EmptyTextField(text: String, message: String?){
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true) }
    
    
}

