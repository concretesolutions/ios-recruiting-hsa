//
//  FavoritesTableViewController.swift
//  Movs
//
//  Created by Jose Antonio Aravena on 9/3/19.
//  Copyright © 2019 Jose Antonio Aravena. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableData: [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17"]
    
    let cellReuseIdentifier = "cell"
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! FavoriteTableViewCell?)!
        //cell.accessoryType = .disclosureIndicator
        //cell.addSubview(SwiftDisclosureIndicator.init())
        let view = SwiftDisclosureIndicator.init()
        view.color = UIColor.negro
        view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        view.backgroundColor = UIColor.white
        cell.accessoryView = view
        
        cell.textLabel?.text = self.tableData[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            tableData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}









class SwiftDisclosureIndicator: UIView {
    var color = UIColor.red
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let x = self.bounds.maxX - 2
        let y = self.bounds.midY
        let R = CGFloat(4.5)
        context!.move(to: CGPoint(x: x - R, y: y - R))
        context!.addLine(to: CGPoint(x: x, y: y))
        context!.addLine(to:CGPoint(x: x - R, y: y + R))
        context!.setLineCap(CGLineCap.square)
        context!.setLineJoin(CGLineJoin.miter)
        context!.setLineWidth(2)
        color.setStroke()
        context!.strokePath()
    }
    
}
