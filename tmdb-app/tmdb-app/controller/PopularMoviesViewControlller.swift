//
//  PopularMoviesViewControlller.swift
//  tmdb-app
//
//  Created by training on 01-07-22.
//

import Foundation
import UIKit
import Alamofire

var favoriteList = [MovFavTmdb]()

class PopularMoviesViewController: UIViewController,  MyCellDelegate{
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var results : [PopularMovie] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 200)
        moviesCollectionView.collectionViewLayout = layout
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        setupView()
    }
    
    func cellWasPressed(selectedMovieId: String) {
        
        performSegue(withIdentifier: "MovieDetailVC", sender: selectedMovieId)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if (segue.identifier == "MovieDetailVC") {
          let detailView = segue.destination as! MovieDetailViewController
          let selectedMovieId = sender as! String
           detailView.movieId = selectedMovieId
       }
    }

    
    func setupView() {
        print("popular_movies_endpoint: \(Endpoints.popularMovies)")
        AF.request(Endpoints.popularMovies).response {
            response in
            
            if response.error != nil {
                print("internal server error")
                return
            }

            guard let data = response.data else {
                print("not found")
                return
            }
            
            print("before decode")
            //print("data: \(data)")
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(PopularMovieResponse.self, from: data)
                
                guard let optionalResults = response.results else {
                    return
                }
                
                //print("results: \(optionalResults)")
                
                self.results = optionalResults
                self.moviesCollectionView.reloadData()
                

            } catch let error {
                
                let alert = UIAlertController(title: "Popular Movies", message: "Ha ocurrido un error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok" , style: .default, handler: { action in
                    switch action.style{
                        case .default:
                            print(error)
                        
                        case .cancel:
                            print("")
                            
                        case .destructive:
                            print("")
                            
                        @unknown default:
                            print("")
                        
                    }
                }))
                self.present(alert, animated: true, completion: nil)
               
            }
        }
        
    }
    
}

extension PopularMoviesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        //revisar
        print("you tapped me")
    }
}

extension PopularMoviesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        print("results.count: \(self.results.count)")
        return self.results.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollViewCell.identifier, for: indexPath) as! MovieCollViewCell
        
        cell.delegate = self
        //se valida que la película en el índice x tenga datos
        cell.configure(with: results[indexPath.row])
        
        return cell
        
    }
    
}
    // revisar mas adelante
extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 190, height: 250)
    }
}

protocol MyCellDelegate {
    func cellWasPressed(selectedMovieId: String)
}
