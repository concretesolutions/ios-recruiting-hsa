//
//  HomeMovieViewController + TableViewDelegateDataSources.swift
//  MovieScope
//
//  Created by Andrés Alexis Rivas Solorzano on 7/3/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import Foundation
import UIKit

//Archivo de extension dedicado unicamente a configurar los delegate y datasource del home
extension HomeMovieViewController: UITableViewDelegate, UITableViewDataSource, HomeTableViewHeaderDelegate{
    
    //Personalmente me gusta hacer los settings de los tableview en codigo pero también entiendo la posibilidad de realizarlo por el .xib / Storyboard
    func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.register(HomeTableViewHeader.self, forHeaderFooterViewReuseIdentifier: HomeHeadersIdentifiers.homeHeader.rawValue)
        tableView.backgroundColor = .appBackgroundColor
        tableView.estimatedSectionHeaderHeight = 54
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
        let refreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action: #selector(refreshTableView(_:)), for: .valueChanged)
        
        tableView.refreshControl = refreshControl
        //Cada vez que se añada un nuevo tipo de sección se registrará la celda correspondiente a esa sección
        HomeSectionType.allCases.forEach{ type in
            let cellType = type.rowCellType
            self.tableView.register(UINib.init(nibName: cellType.reuseIdentifier, bundle: nil), forCellReuseIdentifier: cellType.reuseIdentifier)
        }
    }
    
    @objc func refreshTableView(_ sender: UIRefreshControl){
        sender.endRefreshing()
        viewModel.fetchData()
    }
    
    func showMovieList(forSection: Int) {
        viewModel.showMovieList(sectionIndex: forSection)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.homeSections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let currentSection = viewModel.homeSections[section].type
        switch currentSection {
        case .topRated, .popular, .upcoming:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = viewModel.homeSections[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: section.reuseIdentifier , for: indexPath)
        if var cellConfigurable = cell as? HomeConfigurableCell{
            cellConfigurable.setViewModel(viewModel: section.viewModel)
            cellConfigurable.delegate = self
            
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeHeadersIdentifiers.homeHeader.rawValue) as! HomeTableViewHeader
        header.titleLb.text = viewModel.homeSections[section].type.rawValue
        header.delegate = self
        header.currentSectionIndex = section
        return header
    }
    
}
