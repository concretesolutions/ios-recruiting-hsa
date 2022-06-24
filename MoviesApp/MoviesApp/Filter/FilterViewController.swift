//
//  FilterViewController.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import UIKit

protocol ReturnFilterDelegate: AnyObject {
    func returnFilter(year: Int, genre: String)
}

// MARK: -
class FilterViewController: UIViewController, FilterPresenterDelegate {
    var options: [Option] = []
    @IBOutlet weak var optionsTableView: UITableView!
    var presenter: FilterPresenter = FilterPresenter()
    weak var delegate: ReturnFilterDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setViewDelegate(delegate: self)
        presenter.getOptions()
        // Do any additional setup after loading the view.
        optionsTableView.dataSource = self
        optionsTableView.delegate = self
        navigationController?.navigationBar.backgroundColor = UIColor(named: ColorsMovie.Yellow)
        tabBarController?.tabBar.backgroundColor = UIColor(named: ColorsMovie.Yellow)
    }

    func presenteOptionsFilter(options: [Option]) {
        self.options = options
        self.optionsTableView.reloadData()
    }

    @IBAction func touchApplyFilter(_ sender: Any) {
        delegate?.returnFilter(year: Int(options[0].result) ?? 0, genre: options[1].result)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: -
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Cells.movieFilterCell) as? FilterTableViewCell {
            let option = options[indexPath.row]
            cell.setConfigurate(option: option)
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: -
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let typeFilter = options[indexPath.row].option
        let viewController = storyboard?.instantiateViewController(withIdentifier: StoryBoardsIDS.idDetailFilter)
                            as? FilterDetailViewController
        viewController?.typeFilter = typeFilter
        viewController?.title = typeFilter.rawValue
        viewController?.delegate = self
        navigationController?.pushViewController(viewController!, animated: true)
    }
}

// MARK: -

extension FilterViewController: ReturnOptionFilterDelegate {
    func getDate(year: Int) {
        let idx = options.indices.filter { options[$0].option == TypeFilter.date}
        options[idx[0]].result = String(year)
        self.optionsTableView.reloadData()
    }

    func getGenre(genre: Genre) {
        let idx = options.indices.filter { options[$0].option == TypeFilter.genres}
        options[idx[0]].result = (genre.name)
        self.optionsTableView.reloadData()
    }
}
