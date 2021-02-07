//
//  FilterContentViewController.swift
//  Movies
//
//  Created by Alfredo Luco on 07-02-21.
//

import UIKit

class FilterContentViewController: ViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Memory debug
    
    deinit {
        print("filter content vc dealloc")
    }
    
    //MARK: - Variables
    
    var presenter: FilterContentPresenter = FilterContentPresenter()
    var content: [String] = []
    
    //MARK: - App lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.presenter.fetchContent()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    
    func setupUI() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

//MARK: - UITableView Delegate & Data Source

extension FilterContentViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = self.content[indexPath.row]
        return cell
    }
}

//MARK: - Display Logic
extension FilterContentViewController: PresenterToViewFilterContentProtocol {
    func fetchContentSuccessfull(_ content: [String]) {
        self.content = content
        self.tableView.reloadData()
    }
    
    func failure(_ error: Error) {
        let alert = UIAlertController(title: "ATENCION", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
