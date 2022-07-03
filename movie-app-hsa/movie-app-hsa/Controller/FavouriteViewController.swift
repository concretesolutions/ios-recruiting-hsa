//
//  FavouriteViewController.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import UIKit

class FavouriteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let favouriteManager = FavouriteManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }

    func setup() {
        favouriteManager.lists()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouriteManager.count()
 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favouriteCell:FavouriteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteTableViewCell
        
        
//        let carsList = favouriteManager.shared.cars
//
//        let carObject = carsList[indexPath.row]
//
//        plantillaCelda.plateLabel.text = carObject.plate
//        plantillaCelda.nameLabel.text = carObject.name
//        plantillaCelda.modelLabel.text = carObject.model
//
        return favouriteCell
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
