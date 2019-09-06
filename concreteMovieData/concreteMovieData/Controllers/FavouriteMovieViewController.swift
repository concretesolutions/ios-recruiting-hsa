//
//  FavouriteMovieViewController.swift
//  concreteMovieData
//
//  Created by Christopher Parraguez on 9/6/19.
//  Copyright © 2019 Christopher Parraguez. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class FavouriteMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var favouriteTable: UITableView!
    var resultSearch: ResultResponse!
    var resultSearchArray: [MovieResponse]!

    override func viewDidLoad() {
        super.viewDidLoad()
        callMovies()
        // Do any additional setup after loading the view.
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
                        self.favouriteTable.delegate = self
                        self.favouriteTable.dataSource = self
                        self.favouriteTable.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouriteTableViewCell")
                        self.favouriteTable.reloadData()
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
    //    MARK: TableViewDelegates

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearch.results.isEmpty{
            return 0
        }else{
            return self.resultSearch.results.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favouriteTable.dequeueReusableCell(withIdentifier: "FavouriteTableViewCell", for: indexPath) as! FavouriteTableViewCell
        if self.resultSearch.results.isEmpty{
            return cell
        }else{
            cell.name = self.resultSearch.results[indexPath.row].title
            if self.resultSearch.results[indexPath.row].poster_path != nil{
                cell.urlImage = self.resultSearch.results[indexPath.row].poster_path
                cell.overview = self.resultSearch.results[indexPath.row].overview
                cell.date = self.resultSearch.results[indexPath.row].getYearToDateString()
            }
        }
        return cell

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
