//
//  FiltersViewController.swift
//  movs
//
//  Created by Andrés Alexis Rivas Solorzano on 10/6/19.
//  Copyright © 2019 Andrés Alexis Rivas Solorzano. All rights reserved.
//

import UIKit

protocol FiltersSelectionDelegate: class {
    func updateFilters(filterList: [FilterModel])
}

protocol FiltersDisplayLogic: class {
    func updateViewModel(viewModel: FiltersViewModel)
}

class FiltersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    private let router: FiltersRouter
    private var interactor: FiltersBusinessLogic?
    private var viewModel: FiltersViewModel?{
        didSet{
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    weak var delegate: FiltersSelectionDelegate?
    
    init(router: FiltersRouter, filtersList: [FilterModel], delegate: FiltersSelectionDelegate){
        self.router = router
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        setup(filtersList: filtersList)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        filterButton.backgroundColor = .buttercup
        filterButton.setTitleColor(.white, for: .normal)
        filterButton.roundBorder(radius: 5.0)
        filterButton.setTitle(LocalizableStrings.filterAction.localized, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        router.updateNavigationTitle()
        interactor?.prepareFilters()
    }
    private func setup(filtersList: [FilterModel]){
        let presenter = FiltersPresenter(view: self)
        interactor = FilterInteractor(presenter: presenter, filters: filtersList)
    }
    
    private func updateUI(){
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView.reloadSections(sections as IndexSet, with: .automatic)
    }

    @IBAction func filterAction(_ sender: Any) {
        router.routeToList {
            guard let interactor = interactor else { return }
            delegate?.updateFilters(filterList: interactor.getFilters())
        }
    }
}

extension FiltersViewController: FiltersDisplayLogic{
    func updateViewModel(viewModel: FiltersViewModel) {
        self.viewModel = viewModel
    }
}
extension FiltersViewController: UITableViewDataSource, UITableViewDelegate{
    
    private func setupTableView(){
        tableView.register(UINib.init(nibName: AutoSizeTitleTableCell.reuseIdentifier, bundle: nil),
                           forCellReuseIdentifier: AutoSizeTitleTableCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getFiltersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if viewModel.isRoot{
            let rootFilter = viewModel.values[indexPath.row]
            interactor?.didSelectFilter(type: rootFilter.type)
        }else if let filterName = viewModel.getFilterName(at: indexPath.row){
            interactor?.didSelectSubFilter(name: filterName, type: viewModel.type)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AutoSizeTitleTableCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? AutoSizeTitleTableCell, let filterName = viewModel?.getFilterName(at: indexPath.row){
            cell.titleLabel.text = filterName
            cell.accessoryType = cellAccessory(at: indexPath.row)
        }
        return cell
    }
    
    private func cellAccessory(at index: Int)->UITableViewCell.AccessoryType{
        guard let viewModel = viewModel else { return .none }
        if viewModel.isRoot{
            return .disclosureIndicator
        }else if let currentValue = viewModel.getFilter(at: index), currentValue.isSelected{
            return .checkmark
        }else{
            return .none
        }
    }
    
}
