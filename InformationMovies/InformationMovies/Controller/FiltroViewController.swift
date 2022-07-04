//
//  FiltroViewController.swift
//  InformationMovies
//
//  Created by Cristian Bahamondes on 30-06-22.
//

import UIKit

class FiltroViewController: UIViewController {

    @IBOutlet weak var tablaFiltro: UITableView!
    @IBOutlet weak var aplicarFiltroButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tablaFiltro.dataSource = self
        tablaFiltro.delegate = self
        aplicarFiltroButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tablaFiltro.reloadData()
        
        if FilterInfo.shared.categoriSelected.count > 0 || FilterInfo.shared.yearSelected.count > 0 {
            aplicarFiltroButton.isEnabled = true
        }
        
    }
    
    @IBAction func onTapBackFavorites(_ sender: Any) {
        
        FilterInfo.shared.applyCategory = false
        FilterInfo.shared.applyYear = false
        FilterInfo.shared.categoriSelected = String()
        FilterInfo.shared.yearSelected = String()
        FilterInfo.shared.itemsFilter[0] = "Año"
        FilterInfo.shared.itemsFilter[1] = "Género"
        tablaFiltro.reloadData()
        self.dismiss(animated: true)
    }
    
    @IBAction func onTapAplicarFiltro(_ sender: Any) {
        
        if FilterInfo.shared.categoriSelected.count > 0 {
            FilterInfo.shared.applyCategory = true
        }
        
        if FilterInfo.shared.yearSelected.count > 0 {
            FilterInfo.shared.applyYear = true
        }
        
        self.dismiss(animated: true)
    }
    

}
//MARK: Extension data source
extension FiltroViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FilterInfo.shared.itemsFilter.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CeldaFiltro")
        cell.accessoryType = .disclosureIndicator
        
        if FilterInfo.shared.categoriSelected == "" && FilterInfo.shared.yearSelected == "" {
            
            cell.textLabel?.text = FilterInfo.shared.itemsFilter[indexPath.row]
        }
        
        else
        {
            if FilterInfo.shared.yearSelected == "" && FilterInfo.shared.categoriSelected != "" {
                
                FilterInfo.shared.itemsFilter[1] = FilterInfo.shared.categoriSelected
                cell.textLabel?.text = FilterInfo.shared.itemsFilter[indexPath.row]
            }
            
            if FilterInfo.shared.yearSelected != "" && FilterInfo.shared.categoriSelected == "" {
                
                FilterInfo.shared.itemsFilter[0] = FilterInfo.shared.yearSelected
                cell.textLabel?.text = FilterInfo.shared.itemsFilter[indexPath.row]
            }
            
            if FilterInfo.shared.yearSelected != "" && FilterInfo.shared.categoriSelected != "" {
            
                FilterInfo.shared.itemsFilter[0] = FilterInfo.shared.yearSelected
                FilterInfo.shared.itemsFilter[1] = FilterInfo.shared.categoriSelected
                cell.textLabel?.text = FilterInfo.shared.itemsFilter[indexPath.row]
            }
        }
        
        return cell
    }
    
}

//MARK: Extension delegado
extension FiltroViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let numCelda = indexPath.row
        self.performSegue(withIdentifier: "PantallaDetalleFiltro", sender: numCelda)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "PantallaDetalleFiltro"
        {
            let numRecibido = sender as! Int
            let objSiguientePantalla:DetalleFiltroViewController = segue.destination as! DetalleFiltroViewController
            
            objSiguientePantalla.numFilaRecibido = numRecibido
        }
    }
}


