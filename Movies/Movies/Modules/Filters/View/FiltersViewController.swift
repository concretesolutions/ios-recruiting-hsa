//
//  FiltersViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import UIKit

class FiltersViewController: ViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Memory debug
    
    deinit {
        print("Filters vc dealloc")
    }
    
    //MARK: - Variables
    
    var presenter: FiltersPresenter = FiltersPresenter()
    var filters: [Filter<String>] = []
    
    //MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.presenter.fetchFilters()
        // Do any additional setup after loading the view.
    }

    //MARK: - Functions
    
    func setupUI() {
        self.tableView.register(UINib(nibName: String(describing: FilterTableViewCell.self), bundle: Bundle(for: FilterTableViewCell.self)), forCellReuseIdentifier: "filterIdentifier")
        self.tableView.backgroundColor = .white
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

//MARK: - TableView Delegate & DataSource

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "filterIdentifier", for: indexPath) as? FilterTableViewCell else {
            return UITableViewCell()
        }
        cell.filter = self.filters[indexPath.row]
        return cell
    }
}


//MARK: - Display Logic

extension FiltersViewController: PresenterToViewFiltersProtocol {
    func fetchFiltersSuccessfull(_ filters: [Filter<String>]) {
        self.filters = filters
        self.tableView.reloadData()
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "ATENCION", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
