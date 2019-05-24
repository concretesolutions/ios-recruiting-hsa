//
//  ViewController.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 22/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class SearchMovieVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var searchBoxText: UITextField!    
    @IBOutlet weak var movieCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        movieCollection.delegate = self
        movieCollection.dataSource = self
        
        searchBtn.isHidden = true
        
        spinner.isHidden = true
        
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
        
        return MovieCell()
    }
    
    
    @IBAction func messageBoxEditing(_ sender: Any) {
        if searchBoxText.text == "" {
            searchBtn.isHidden = true
        } else {searchBtn.isHidden = false }
    }
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        guard let searchTxt = searchBoxText.text , searchBoxText.text != "" else {
            EmptyTextField(text: "Preencha o campo Search", message: "O campo de busca deve ser preenchido")
            return }
        
        spinner.isHidden = false
        spinner.startAnimating()
        
        MovieServices.instance.clearUser()
        
        MovieServices.instance.findSearchMovies(query: searchTxt) { (success,errorMessage) in
            if success{
                print ("Entrou no SearchBtn")
                self.spinner.isHidden = true
                self.spinner.stopAnimating()
                self.movieCollection.reloadData()
            }
            else{
                let message = errorMessage
                print(message)
                self.EmptyTextField(text: "Pay Atention", message: message)
            }
        }
    }
    
    
    func EmptyTextField(text: String, message: String?){
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true) }
    
    
}

