//
//  FilterDetailViewController.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 17/06/22.
//

import UIKit


protocol  ReturnOptionFilterDelegate:AnyObject{
    func getDate(year:Int)
    func getGenre(genre:Genre)
}
//MARK: -
class FilterDetailViewController: UIViewController{
    @IBOutlet weak var detailsTableView: UITableView!
    var presenter: FilterDtlPresenter = FilterDtlPresenter()
    var typeFilter: TypeFilter = .none
    var years:[Int] = []
    var genres:[Genre] = []
    weak var delegate: ReturnOptionFilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        presenter.setViewDelegate(delegate: self)
        // Do any additional setup after loading the view.
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        detailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Cells.movieFilterDetailCell)

        setFilter()
        navigationController?.navigationBar.backgroundColor = UIColor(named:ColorsMovie.Yellow)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        detailsTableView.frame = view.bounds
    }
    func setFilter(){
        
        switch self.typeFilter {
            case .date: presenter.getDate()
            case .genres: presenter.getGenres()
            default:
                return
        }
    }
  
}

//MARK: -
extension FilterDetailViewController:FilterDtlPresenterDelegate {
    func presentDate(years: [Int]) {
        self.years = years
        self.detailsTableView.reloadData()
    }
    
    func presentGenres(genres: [Genre]) {
        self.genres = genres
        DispatchQueue.main.sync {
            self.detailsTableView.reloadData()
        }
    }
    
    func showError(error: Error) {
        AlertMovie.showBasicAlert(in:self, title: AlertConstant.Error, message: error.localizedDescription)
    }
}

//MARK: -
extension FilterDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.typeFilter{
        case .date:
                return years.count
        case .genres:
                return genres.count
        default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Cells.movieFilterDetailCell,for:indexPath)
        
        cell.textLabel?.text = self.typeFilter == .genres ? genres[indexPath.row].name : String(years[indexPath.row])
        
        return cell
    }
    
}

//MARK: -
extension FilterDetailViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        tableView.deselectRow(at: indexPath, animated: false)

        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        if self.typeFilter == .genres{
            delegate?.getGenre(genre:self.genres[indexPath.row])
        } else{
            delegate?.getDate(year: self.years[indexPath.row])
        }
        
        cell.accessoryType = .checkmark
        self.navigationController?.popViewController(animated: true)
    }
}