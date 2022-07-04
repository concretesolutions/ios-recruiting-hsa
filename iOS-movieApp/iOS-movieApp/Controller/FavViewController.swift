//
//  FavViewController.swift
//  iOS-movieApp
//
//  Created by alvaro.concha on 30-06-22.
//

import UIKit

class FavViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var FavMoviesTableView : UITableView!
    
    let userDefaults = UserDefaults.standard
    var idsPopularMovies : [Int]?
    var popularMovies : [MovieResult] = []
    var favMovies : [MovieResult] = []
    var movieSelectedForSend : MovieResult?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if checkPopularMovies(){
            setupUI()
        }
        createTimer()
    }
    
    func setupUI(){
        let apiManager = APIManager()

        apiManager.getPopularMovies { (MovieResult) in
            
            guard let movie = MovieResult else{ return }
            self.popularMovies = movie
            
            self.favMovies = self.getFavMovies(arrIds: self.idsPopularMovies!)
        
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTableFavs", for: indexPath) as! ItemFavTableViewCell
        
        cell.pictureMovieImageView.downloaded(from: Endpoints.images +  self.favMovies[indexPath.row].poster_path )

        cell.pictureMovieImageView.contentMode = .scaleAspectFill
        cell.titleMovieLabel.text = self.favMovies[indexPath.row].title
        cell.desciptionTextView.text = self.favMovies[indexPath.row].overview
        
        let myDate = Date()
        cell.anioMovieLabel.text = myDate.getYearFromString(dateString: self.favMovies[indexPath.row].release_date)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieSelected = favMovies[indexPath.row]
        
        movieSelectedForSend = movieSelected
        self.performSegue(withIdentifier: "favoriteToSingleMovie", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            var indexForDelete : Int = 0
            
            
            let movieToDeleted = self.favMovies[indexPath.row]
            
            for (i, id) in self.idsPopularMovies!.enumerated(){
                if id == movieToDeleted.id{
                   indexForDelete = i
                }
            }
            
            self.idsPopularMovies?.remove(at: indexForDelete)
            
            userDefaults.set(self.idsPopularMovies, forKey: "idsPopularMovies")
            userDefaults.synchronize()
            
            self.favMovies.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let singleMovieViewController = segue.destination as? SingleMovieViewController {
            guard let movieForSend = movieSelectedForSend else { return }
            singleMovieViewController.Movie = movieForSend
        }
    }



    
    private func getFavMovies(arrIds : [Int]) -> [MovieResult]{
        var favMovies : [MovieResult] = []
        for popularMovie in self.popularMovies{
            for id in arrIds{
                if(popularMovie.id == id){
                    favMovies.append(popularMovie)
                }
            }
        }
        return favMovies
    }
    
    
    private func checkPopularMovies() -> Bool {
        
        guard let popular = userDefaults.object(forKey: "idsPopularMovies") as? [Int] else { return false }
        idsPopularMovies = popular
        return true
        
    }
    
    
    func createTimer(){

        
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            
            timer.fire()
        }
    }
    
    
    @objc func fireTimer() {

        FavMoviesTableView.reloadData()

    }

}
