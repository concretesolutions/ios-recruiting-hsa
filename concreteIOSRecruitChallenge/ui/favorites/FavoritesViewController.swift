//
//  FavoritesViewController.swift
//  concreteIOSRecruitChallenge
//
//  Created by Kristian Sthefan Cortes Prieto on 04-02-21.
//

import UIKit

class FavoritesViewController: CustomViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Outlets

    @IBOutlet var tableView: UITableView?
    
    //MARK: Global Variables
    
    private var viewModel: FavoritesViewModel?
    private var dataList: [MovieEntry?] = []
    
    //MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
        if let table = self.tableView { table.register(nib, forCellReuseIdentifier: "FavoriteTableViewCell") }
        self.viewModel = FavoritesViewModel()
        self.loadData()
    }
    
    func loadData(){
        self.dataList = self.viewModel?.listFavorites() ?? []
        if let table = self.tableView {
            self.dataList.count > 0 ? self.onSuccess(table) : self.onNoData(table)
            table.reloadData()
            
        }
    }
    
    //MARK: TableView Management
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavoriteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.loadCellView(movieEntry: self.dataList[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height * 0.15
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
