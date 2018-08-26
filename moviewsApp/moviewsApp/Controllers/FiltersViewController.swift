

import UIKit

class FiltersViewController: UIViewController {
    
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var valuesFilter : [String] = []
    var level : Int = 0
    var data : [String] = FILTERS
    var optionSelected : Int = 0
    weak var delegate : FavoritesViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0 ..< FILTERS.count {self.valuesFilter.append("")}
        
        self.tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: "Principal")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.applyButton.layer.cornerRadius = 10
        self.view.bringSubview(toFront: self.applyButton)
        
        self.setupContentInset()
        self.setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        self.tabBarController?.tabBar.isTranslucent = true
        self.title = "Filter"
        
        self.tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.title = ""
    }
    
    func generateDatesArray() -> [String]{
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        return Array(MIN_YEAR...year).reversed().map({$0.description})
    }
    
    func setupContentInset(){
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: self.level == 0 ? 60 : 0, right: 0)
    }
    
    func setupNavBar(){
        
        navigationItem.hidesBackButton = true
        
        let buttonBack = UIBarButtonItem(image: #imageLiteral(resourceName: "left-arrow"), style: .plain, target: self, action: #selector(self.goBack))
        navigationItem.leftBarButtonItem = buttonBack
    }
    
    @objc func goBack(){
        if self.level == 0{
            self.navigationController?.popViewController(animated: true)
        }
        else{
            self.level = 0
            self.data = FILTERS
            self.setupContentInset()
            self.applyButton.isHidden = false
            self.tableView.reloadSections(IndexSet(0...0), with: .right)
        }
    }
    
    @IBAction func ApplyFilters(_ sender: UIButton) {
        
        let dictionary = ["date" : valuesFilter[0] , "genre" : valuesFilter[1]]
        self.delegate?.didSelectFilters(array: dictionary)
        self.navigationController?.popViewController(animated: true)
    }
}

extension FiltersViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.level == 1{
            self.valuesFilter[self.optionSelected] = self.data[indexPath.row]
            self.tableView.reloadData()
        }
    }
}

extension FiltersViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Principal", for: indexPath) as! FilterTableViewCell
        if self.level == 0{
            cell.rightLabel.text = self.valuesFilter[indexPath.row]
            cell.rightImage.isHidden = false
            cell.settupCell(typeCell:  "Principal")
            cell.delegate = self
        }
        else{
            cell.rightLabel.text = ""
            cell.rightImage.isHidden = !(self.data[indexPath.row] == self.valuesFilter[self.optionSelected])
            cell.settupCell(typeCell:  "secundary")
        }
        
        cell.leftLabel.text = data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension FiltersViewController : filterCellDelegate{
    func didTapArrow(index: Int) {
        if index == 0 {
            self.data = self.generateDatesArray()
        }
        else{
            self.data = Genre.genres.map({$0.name!})
        }
        self.optionSelected = index
        self.level = 1
        self.setupContentInset()
        self.tableView.reloadSections(IndexSet(0...0), with: .left)
        self.applyButton.isHidden = true
    }
}
