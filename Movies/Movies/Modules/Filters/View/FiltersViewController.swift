//
//  FiltersViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import UIKit

protocol FiltersViewControllerDelegate: class {
    func didFilter(with criteria: [Filter<String>])
}

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
    weak var delegate: FiltersViewControllerDelegate?
    
    //MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.presenter.fetchFilters()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func apply() {
        delegate?.didFilter(with: self.filters)
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: - Functions
    
    func setupUI() {
        self.tableView.register(UINib(nibName: String(describing: FilterTableViewCell.self), bundle: Bundle(for: FilterTableViewCell.self)), forCellReuseIdentifier: "filterIdentifier")
        self.tableView.backgroundColor = .white
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(apply)), animated: true)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let type = indexPath.row == 0 ? FilterContent.years : FilterContent.genres
        let vc = FilterContentRouter.createModule(type)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Filter Content Delegate

extension FiltersViewController: FilterContentViewControllerDelegate {
    func didSelectFilterCriteria(_ type: FilterContent, _ value: String) {
        guard self.filters.count > 0 else { return }
        switch type {
        case .genres:
            self.filters[1].value = value
            break
        case .years:
            self.filters[0].value = value
            break
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
