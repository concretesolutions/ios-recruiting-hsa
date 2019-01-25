//
//  MovieViewController.swift
//  MovieApp
//
//  Created by luis.a.rosas.arce on 21/01/19.
//  Copyright © 2019 luis.a.rosas.arce. All rights reserved.
//

import UIKit

class MovieViewController: BaseViewController {

    @IBOutlet weak var movieCollectionView: UICollectionView!
    var searchController: UISearchController!
    
    // MARK: - Lifecycke
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.topItem?.title = "Movie"
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("SEGUE!!")
    }
    

}

extension MovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
    }
}


extension MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //movieCellIdentifier
        let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCellIdentifier", for: indexPath) as! MovieCollectionViewCell
        movieCell.loadCell(picture: "Imagen", title: "Load", isFavorite: false)
        
        return movieCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2 - 20, height: 100)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item \(indexPath.row)")
        
        self.performSegue(withIdentifier: "showDetailMovieSegue", sender: self)
        
        
    }
}
