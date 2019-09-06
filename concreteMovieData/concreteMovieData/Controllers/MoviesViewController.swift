//
//  ViewController.swift
//  concreteMovieData
//
//  Created by Christopher Parraguez on 8/31/19.
//  Copyright © 2019 Christopher Parraguez. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionMovies: UICollectionView!
    var resultSearch: ResultResponse!
    var resultSearchArray: [MovieResponse] = []
    
    var recordsArray:[Int] = Array()
    var limit = 20
    
    var searchActive : Bool = false



    override func viewDidLoad() {
        super.viewDidLoad()
        callMovies()
        searchBar.delegate = self

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    func callMovies(){
        let url = URL(string: BASEURL + MOVIE + POPULAR)
        let params = ["api_key":APIKEY, "language":"es-ES", "page":"1"] as [String : Any]
        Alamofire.request(url!, method: .get, parameters: params)
            .responseObject { (response: DataResponse<ResultResponse>) in
                switch(response.result){
                case .success(_):
                    self.resultSearch = response.result.value
                    if !self.resultSearch.results.isEmpty{
                        self.collectionMovies.delegate = self
                        self.collectionMovies.dataSource = self
                        self.collectionMovies.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieViewCell")
                        self.collectionMovies.reloadData()
                    }else{
                        let alert = UIAlertController(title: "Alerta", message: "No existen resultados a la busqueda", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    break
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "ERROR", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    break
                }
            }
        }
    
    //    MARK: CollectionViewDelegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchActive{
            return resultSearchArray.count
        }else{
            if self.resultSearch.results.isEmpty{
                return 0
            }else{
                return self.resultSearch.results.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        if searchActive{
            cell.title = self.resultSearchArray[indexPath.row].title
            if self.resultSearchArray[indexPath.row].poster_path != nil{
                cell.urlImage = self.resultSearchArray[indexPath.row].poster_path
                cell.movie = self.resultSearchArray[indexPath.row]
            }
        }else{
            if self.resultSearch.results.isEmpty{
            return cell
            }else{
                cell.title = self.resultSearch.results[indexPath.row].title
                if self.resultSearch.results[indexPath.row].poster_path != nil{
                    cell.urlImage = self.resultSearch.results[indexPath.row].poster_path
                    cell.movie = self.resultSearch.results[indexPath.row]
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !self.resultSearch.results.isEmpty{
            self.performSegue(withIdentifier: "goToMovieDetail", sender: indexPath)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = sender as! IndexPath
        let vc = segue.destination as! MovieDetailViewController //Cast with your DestinationController
        if searchActive{
            vc.idMovie = self.resultSearchArray[indexPath.row].id!.stringValue
        }else{
            vc.idMovie = self.resultSearch.results[indexPath.row].id!.stringValue
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty{
            searchActive = false
            self.collectionMovies.reloadData()
            view.endEditing(true)
            return
        }else{
            searchActive = true
        }
        
        guard let moviesList = resultSearch.results else {return}
        
        let filtered = moviesList.filter({ (movie) -> Bool in
            return movie.title.contains(searchText)
        })
        self.resultSearchArray = filtered
        self.collectionMovies.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if searchBar.text?.isEmpty ?? false{
            searchActive = false
        }else{
            searchActive = true;
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    

}
