//
//  MovieViewController.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/3/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    let imageView = UIImageView()
    let tableView = UITableView()
    
    var titulo:String=""
    var año:Int=2008
    var genero:String=""
    var comentario:String=""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.width - 20)
            ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.width - 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
            ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = self.titulo
        case 1:
            cell?.textLabel?.text = "\(self.año)"
        case 2:
            cell?.textLabel?.text = self.genero
        case 3:
            cell?.textLabel?.text = self.comentario
        default:
            print()
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 3){
            return 200
        }
        else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
