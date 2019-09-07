//
//  FilterViewController.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/4/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {


    private var tabla:UITableView = UITableView()
    var tableData: [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        tabla = UITableView(frame: CGRect(x: 0, y: barHeight, width: self.view.frame.width, height: self.view.frame.height - barHeight))
        tabla.register(UITableViewCell.self, forCellReuseIdentifier: "FilterCell")
        tabla.dataSource = self
        tabla.delegate = self
        self.view.addSubview(tabla)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tabla.dequeueReusableCell(withIdentifier: "FilterCell") 
        cell!.accessoryType = .disclosureIndicator
        cell!.addSubview(SwiftDisclosureIndicator.init())
        
        let view = SwiftDisclosureIndicator.init()
        view.color = UIColor.negro
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.backgroundColor = UIColor.white
        cell!.accessoryView = view
        
        return cell!
    }
    

}
