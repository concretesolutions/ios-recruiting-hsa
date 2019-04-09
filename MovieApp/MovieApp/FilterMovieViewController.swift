//
//  FilterMovieViewController.swift
//  MovieApp
//
//  Created by DeveloperOSA on 4/8/19.
//  Copyright © 2019 Accenture. All rights reserved.
//

import UIKit
import RealmSwift

protocol FilterMovieViewDelegate {
    func filterSelected(filter : [String:String])
}


class FilterMovieViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    
    var data : [String:[String]] = ["Genres":[],"Date":[]]
    var menu : [String]{
        get{
           return Array(data.keys)
        }
    }
    
    var selectedData : [String:String] = ["":""]
    var delegate : FilterMovieViewDelegate?
    
    static let filterSelectedOptions = NSNotification.Name("filterSelectedOptions")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        data["Genres"] = GenreInteractor.shared.genresList.map{$0.name}
        NotificationCenter.default.addObserver(self, selector: #selector(dataFromSelectFilter(notification:)), name: FilterMovieViewController.filterSelectedOptions, object: nil)
        
        do {
            let realm = try Realm()
            let dateList = realm.objects(Movie.self).toArray(ofType: Movie.self).map{$0.releaseDate}
            data["Date"] = dateList.unique()
        } catch let error  {
            //TODO catch error
        }

        tableView.tableFooterView = UIView(frame: .zero)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let delegateAction = delegate {
            delegateAction.filterSelected(filter: selectedData)
        }
    }

}

extension FilterMovieViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELLMENU")
        if cell == nil { cell = UITableViewCell(style:.value1, reuseIdentifier: "CELLMENU") }
        cell!.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = menu[indexPath.row]
        cell?.detailTextLabel?.text = selectedData[menu[indexPath.row]]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @objc func dataFromSelectFilter(notification: Notification){
        let data = notification.userInfo as? [String:String]
        let key = Array(data!.keys)[0]
        let value = data![key]
        selectedData[key] = value
    }
}


extension FilterMovieViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let dest = SelectionFilterTableViewController(nibName: "SelectionFilterTableViewController", bundle: nil)
        dest.key = menu[indexPath.row]
        dest.items = data[menu[indexPath.row]]!
        self.show(dest, sender: nil)
    }
}


