//
//  FavoriteFiltersViewController.swift
//  Movies
//
//  Created by Pedro on 26-07-24.
//

import UIKit
import Combine

/// I did not plan to implement this view originally,
/// but I did it anyway by omitting a coordinator and the viewmodel
/// Also using a .xib for quick UI setup
class FavoriteFiltersViewController: UIViewController {
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    var year: String?
    var genre: Genre?
    var cancellables = Set<AnyCancellable>()
    weak var delegate: FavouriteFiltersDelegate?
    let genreUseCase: GetGenresUseCase

    init(year: String?, genre: Genre?, genreUseCase: GetGenresUseCase, delegate: FavouriteFiltersDelegate?) {
        self.genreUseCase = genreUseCase
        super.init(nibName: nil, bundle: nil)
        self.year = year
        self.genre = genre
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yearLabel.text = year
        genreLabel.text = genre?.name
    }

    @IBAction func applyFiltersButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        delegate?.didEndPickingFilters(year: year, genre: genre)
    }
    
    @IBAction func yearPickerTapped(_ sender: Any) {
        let currentYear = Calendar.current.component(.year, from: Date())
        let data = Array((1950...currentYear).map { "\($0)"}.reversed())
        let yearPickerViewController = TablePickerViewController(
            data: data,
            selectedValue: year) { [weak self] selectedYear in
                self?.year = selectedYear
                self?.yearLabel.text = selectedYear
            }
        navigationController?.pushViewController(yearPickerViewController, animated: true)
    }

    @IBAction func genrePickerTapped(_ sender: Any) {
        let selectedGenre = genre?.name
        genreUseCase
            .execute()
            .replaceError(with: [])
            .sink { [weak self] genres in
                let data = genres.map { "\($0.name)"}
                let genrePickerViewController = TablePickerViewController(
                    data: data,
                    selectedValue: selectedGenre) { [weak self] selectedGenre in
                        self?.genre = genres.first { $0.name == selectedGenre }
                        self?.genreLabel.text = selectedGenre
                    }
                self?.navigationController?.pushViewController(genrePickerViewController, animated: true)
            }.store(in: &cancellables)
    }
}

protocol FavouriteFiltersDelegate: AnyObject {
    func didEndPickingFilters(year: String?, genre: Genre?)
}

class TablePickerViewController: UIViewController {
    let completion: (String?) -> Void
    var selectedValue: String?
    var data: [String]
    let tableView = UITableView()
    let cellId = "cell"

    init(data: [String], selectedValue: String?, completion: @escaping (String?) -> Void) {
        self.data = data
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
        self.selectedValue = selectedValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self

        if let selectedValue, let index = data.firstIndex(of: selectedValue) {
            let indexPath = IndexPath(row: index, section: 0)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        completion(selectedValue)
    }
}

extension TablePickerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let text = data[safe: indexPath.row]
        cell.textLabel?.text = text
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let value = data[safe: indexPath.row] {
            selectedValue = value
        }
    }
}
