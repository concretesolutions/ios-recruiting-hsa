//
//  ViewController.swift
//  Movies
//
//  Created by Consultor on 12/12/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    var moviesArray: [Movie] = []
    @IBOutlet weak var movieGridCollectionView: UICollectionView!{
        didSet{
            movieGridCollectionView.dataSource = self
            movieGridCollectionView.delegate = self
        }
    }
    
    let cellIdentifier = "MovieGridCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Movies"
        let network = NetworkAPIManager()
        let params = ["api_key":network.apiKey,"page":1] as [String : Any]
        network.request(urlString: "movie/popular", params: params){
            response in
            if let array = response?.results {
                self.moviesArray = array
                self.movieGridCollectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMovieDetail"{
            if let destination = segue.destination as? MovieDetailViewController {
                destination.movie = sender as? Movie
            }
        }
    }
    
}
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? MovieCollectionViewCell {
            cell.movie = moviesArray[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowMovieDetail", sender: moviesArray[indexPath.item])
    }
    
}

