//
//  SplashViewController.swift
//  proyMovieDB
//
//  Created by Tabata Céspedes Figueroa on 29-05-23.
//

import UIKit

class SplashViewController: UIViewController {

    var consumirAPI = ConsumirAPI()

    @IBOutlet weak var cargaSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargaSpinner.startAnimating()
        consumirAPI.obtenerListadoPeliculasPopulares()
        consumirAPI.obtenerGeneros()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3){
            self.performSegue(withIdentifier: "GoHome", sender: nil)
        }
    }
}
