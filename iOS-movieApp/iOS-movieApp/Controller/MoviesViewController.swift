//
//  MoviesViewController.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 30-06-22.
//

import UIKit



class MoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var MoviesCollectionView : UICollectionView!
    @IBOutlet weak var Spinner : UIActivityIndicatorView!
    
    var popularMovies : [MovieResult] = []
    var movieSelectedForSend : MovieResult? = nil
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        createTimer()
    }
    
    func setupUI(){
        let apiManager = APIManager()

        apiManager.getPopularMovies { (MovieResult) in
            
            guard let movie = MovieResult else{ return }
            self.popularMovies = movie
        }
    }
    

    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.popularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemMoviesCollection", for: indexPath) as! ItemCollectionViewCell
        
        
        
        cell.imageItemImageView.downloaded(from: Endpoints.images +  self.popularMovies[indexPath.row].poster_path )
        
        cell.imageItemImageView.contentMode = .scaleAspectFill
        
        
    
        cell.titleItemLabel.text = self.popularMovies[indexPath.row].title
        
        

        return cell
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, sizeForItemAt indexPath : IndexPath) -> CGSize{
        let collectionWidth = MoviesCollectionView.bounds.width
        
        return CGSize(width: collectionWidth/3, height: collectionWidth/3)
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, minimumInteritemSpacingForSectionAt section : Int) -> CGFloat{
        return 2
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, minimumLineSpacingForSectionAt section : Int) -> CGFloat{
        return 2
    }
    
    func collectionView(_ collectionView : UICollectionView, layout collectionViewLayout : UICollectionViewLayout, insetForSectionAt section : Int) -> UIEdgeInsets{
        
        return UIEdgeInsets(top: 5, left: 2, bottom: 0, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieSelected = popularMovies[indexPath.row]
        
        
        
        movieSelectedForSend = movieSelected
        
        
        self.performSegue(withIdentifier: "moviesToSingleMovies", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let singleMovieViewController = segue.destination as? SingleMovieViewController {
            guard let movieForSend = movieSelectedForSend else { return }
            singleMovieViewController.Movie = movieForSend
        }
    }
    
    
    
    func createTimer(){
        
        self.Spinner.isHidden = false
        self.Spinner.startAnimating()
        
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            
            timer.fire()
        }
    }
    
    
    @objc func fireTimer() {
        self.Spinner.hidesWhenStopped = true
        self.Spinner.stopAnimating()
        MoviesCollectionView.reloadData()

    }
    
}
