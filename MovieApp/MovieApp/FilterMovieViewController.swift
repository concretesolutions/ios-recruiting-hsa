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

protocol FilterMovieViewProtocol{
    func showDataFilter(data : [String:[String]])
}


class FilterMovieViewController: UIViewController {
    
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    var data : [String:[String]] = ["Date":[]]
    var menu : [String]{
        get{
           return Array(data.keys)
        }
    }
    
    var selectedData : [String:String] = [:]
    var delegate : FilterMovieViewDelegate?
    var presenter : MovieFilterPresenter?
    
    static let filterSelectedOptions = NSNotification.Name("filterSelectedOptions")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = MovieFilterPresenter()
        presenter?.attachView(view: self)
        presenter?.fetchDataFilter()
    
        NotificationCenter.default.addObserver(self, selector: #selector(dataFromSelectFilter(notification:)), name: FilterMovieViewController.filterSelectedOptions, object: nil)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func tableViewConfig(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @IBAction func apllyButtonAction(_ sender: UIButton) {
        if let delegateAction = delegate {
            delegateAction.filterSelected(filter: selectedData)
        }
        self.navigationController!.popViewController(animated: true)
    }
}

extension FilterMovieViewController : FilterMovieViewProtocol{
    func showDataFilter(data : [String:[String]]){
        self.data = data
        self.tableView.reloadData()
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


