//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Accenture on 27-06-22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Populares"]
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ConfigureTableCell.self, forCellReuseIdentifier: ConfigureTableCell.identifier)
        //table.backgroundColor = .black
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    //ESTABLECE UN NUMERO DE SECCIONES DE LA TABLA
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //CAMBIA LA CANTIDAD DE FILAS QUE SE MUESTRAN EN LA TABLA
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //OBTIENE EL LISTADO DE PELICULAS DE LA API Y LAS CARGA EN LAS CELDAS DE LA UITABLEVIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConfigureTableCell.identifier, for: indexPath) as? ConfigureTableCell else{
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        RestApi.shared.getPopular { result in
            switch result {
            case .success(let titles):
                cell.configure(with: titles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        return cell
    }
        
    
    //CAMBIA LA ALTURA DE LA FILA
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //LE DA FORMATO AL ENCABEZADO
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return sectionTitles[section]
    }
}

//OBTIENE LOS DETALLES POR PELICULA Y LLAMA AL CONTROLADOR QUE MUESTRA LOS DETALLES DE PELICULAS (MovieDetailsController)
extension HomeViewController: ProtocolDetailsMovie {

    func viewDetailsMovie(_ cell: ConfigureTableCell, viewModel: MovieViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = MovieDetailsController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
