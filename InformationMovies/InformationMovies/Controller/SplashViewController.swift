//
//  SplashViewController.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 25-06-22.
//

import UIKit

class SplashViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[EntidadNumeroFila]?

    override func viewDidLoad() {
        super.viewDidLoad()

        ConsumeAPI.shared.getPopularMovies()
        ConsumeAPI.shared.getCategorias()
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
            self.getPersistItem()
            self.performSegue(withIdentifier: "OpenHome", sender: nil)
        }
    }
    
    func getPersistItem() {

        do {
            self.items = try context.fetch(EntidadNumeroFila.fetchRequest())
            
            DispatchQueue.main.async {
                self.items!.forEach { indexAUX in

                    ResponsePopularMovies.shared.results.forEach { dataPopular in
                        if dataPopular.id == indexAUX.idMovie {
                            FavoriteMovies.shared.agregarFavorito(datos: dataPopular)
                        }
                    }
                }
            }
        }
        catch {
            
        }
    }


}
