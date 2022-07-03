//
//  DetalViewController.swift
//  ios-recruiting-hsa
//
//  Created by training on 01-07-22.
//

import UIKit

class DetalViewController: ViewController {

    @IBOutlet weak var detailMovieImageView: UIImageView!
    @IBOutlet weak var nameMovieLabel: UILabel!
    @IBOutlet weak var yearMovieLabel: UILabel!
    @IBOutlet weak var genreMovieLabel: UILabel!
    @IBOutlet weak var overviewMovieLabel: UILabel!
    
    var idMovie: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDetail()
    }
    
    
    func setUpDetail() {
        let api: APIService = APIService()
        api.getDetail(movieId: idMovie, complete: didGetDetail)
       
    }
    
    
    func didGetDetail( _ status: APIStatusType,_ response : DetalMovieResponse?) {
        if status == .success {
            let backdrop_path  = response?.backdrop_path
            detailMovieImageView.loadFrom(URLAddress: IMAGE_URL + backdrop_path!)
            nameMovieLabel.text = response?.title
            yearMovieLabel.text = response?.YearDate()
//            genreMovieLabel.text = response?.genres
            overviewMovieLabel.text = response?.overview
            
            guard let cantElements = response?.id else {
                errorAlertMessage("No fue posible obtener la lista de Peliculas")
                return
            }

            if cantElements == 0 {

                errorAlertMessage("No se han ingresado Peliculas")
                return
            }
                
        } else {
            errorAlertMessage("Error al obtener la lista de Peliculas")
           
        }
        
    }
   
}


