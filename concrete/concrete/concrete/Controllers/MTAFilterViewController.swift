//
//  MTAFilterViewController.swift
//  concrete
//
//  Created by Andres Ortiz on 5/10/19.
//  Copyright © 2019 Andres. All rights reserved.
//

import UIKit

protocol filterDelegate {
    func filterDelegateChageValue(childViewController:MTAFilterViewController, year: Int)
}

class MTAFilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var delegate : filterDelegate?
 
    let tvYears = UITableView()
    
    @objc func goBackAction(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Select a Year"
        self.tvYears.backgroundColor = .black
        self.tvYears.delegate = self
        self.tvYears.dataSource = self
        self.tvYears.separatorStyle = .none
        
        setupViews()
    }
    
    func setupViews(){
        var margins = view.layoutMarginsGuide
        
        if #available(iOS 11.0, *) {
            margins = view.safeAreaLayoutGuide
        }
        
        self.view.backgroundColor = .black
        
        self.view.addSubview(tvYears)
        
        tvYears.translatesAutoresizingMaskIntoConstraints = false
        tvYears.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        tvYears.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tvYears.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0).isActive = true
        tvYears.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0).isActive = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        if indexPath.row == 0{
            cell.textLabel?.text = "No Filter"
        }
        else{
            cell.textLabel?.text = "\(2020 - indexPath.row)"
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 121
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            self.delegate?.filterDelegateChageValue(childViewController: self, year: 0)
        }
        else{
            self.delegate?.filterDelegateChageValue(childViewController: self, year: 2020 - indexPath.row)
        }
        self.navigationController?.popViewController(animated: true)
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
