//
//  FilterViewController.swift
//  movie-app-hsa
//
//  Created by training on 04-07-22.
//

import UIKit

class FilterViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate  {

    var filterList: [String] = ["Años", "Categorías"]
    
    
    @IBOutlet weak var filterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterTableView.dataSource = self
        filterTableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapApply(_ sender: Any) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let filterCell:FilterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterTableViewCell

        print(indexPath.row)
        

        filterCell.filterElementLabel.text = filterList[indexPath.row]
       
        return filterCell
        
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
