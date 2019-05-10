//
//  MTAHome.swift
//  MovieApp
//
//  Created by Andres Ortiz on 4/17/19.
//  Copyright © 2019 Andres. All rights reserved.
//


import UIKit

class MTAHome: UIViewController, UITableViewDataSource, UITableViewDelegate, DetailedMovieDelegate, filterDelegate {
    
    private let cellId = "CustomMovieTableViewCell"
    
    var filteringYear : Int?
    var isFiltered: Bool?
    var isSearching: Bool?
    var isLoading: Bool?
    var page: Int?
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    var category : Int?
    let tableView: UITableView = UITableView()
    
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .whiteLarge)
        loader.color = .black
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    let svCategory : UISegmentedControl = {
        let items = ["Popular", "Top Rated", "Favorites"]
        let customSC = UISegmentedControl(items: items)
        customSC.selectedSegmentIndex = 0
        customSC.layer.cornerRadius = 5.0
        customSC.backgroundColor = .white
        customSC.tintColor = .darkGray
        return customSC
    }()
    
    let vSeachPanel : UIView = {
        let vPanel = UIView()
        vPanel.backgroundColor = UIColor.groupTableViewBackground
        return vPanel
    }()
    
    let txtSearch : UITextField = {
       let text = UITextField()
       text.autocorrectionType = UITextAutocorrectionType.no
       text.borderStyle = UITextField.BorderStyle.roundedRect
       text.backgroundColor = .white
       text.placeholder = "Write something and tab Search..."
       return text
    }()
 
    
    let btnSearch : UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        return button
    }()
    
    let imgPoster : UIImageView = {
        let imgPoster = UIImageView()
        imgPoster.frame = CGRect(x: 10, y: 10, width: 80, height: 120)
        imgPoster.image = UIImage(named: "movieplaceholder")
        
        return imgPoster
    }()

    let lblTitle : UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.frame = CGRect(x: 100, y: 10, width:  UIScreen.main.bounds.width - 160, height: 30)
        label.textAlignment = .left
        return label
    }()
    
    let lblOverview : UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.frame = CGRect(x: 100, y: 50, width:  UIScreen.main.bounds.width - 110, height: 80)
        label.textAlignment = .justified
        label.numberOfLines = 0
        return label
    }()

    let btnClosePreview : UIButton = {
       let button = UIButton()
       button.setTitleColor(.red, for: .normal)
       button.backgroundColor = .white
       button.setTitle("X", for: .normal)
       button.frame = CGRect(x:  UIScreen.main.bounds.width - 40, y: 10, width: 30, height: 30)
       button.layer.masksToBounds = true
       button.layer.cornerRadius = 15
       return button
    }()
    
    let vPreview : UIView = {
        let vPanel = UIView()
        vPanel.backgroundColor = UIColor.groupTableViewBackground
        vPanel.isHidden = true
        return vPanel
    }()

    func detailedMovieDelegateDidPressFavorite(childViewController:MTAMovieDetailedViewController){
        tableView.reloadData()
    }

    func filterDelegateChageValue(childViewController: MTAFilterViewController, year: Int) {
        isFiltered = false
        if year > 0 {
          isFiltered = true
          filteringYear = year
            filteredMovies = movies.filter { ($0.releaseDate?.contains("\(year)-"))! }
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.filteringYear = 0
        self.isFiltered = false
        self.isSearching = false
        self.isLoading = true
        self.page = 1
        self.category = 1
        self.navigationController?.navigationBar.topItem?.title = "Movie App"
        
        setupViews()
        setupActions()
        
        fetchData(text: txtSearch.text!)
    }
    
    override func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        self.tableView.reloadData()
    }
    
    @objc func onFilterClicked(){
        let targetController =  MTAFilterViewController()
        targetController.delegate = self
        self.navigationController?.pushViewController(targetController, animated: true)
    }
    
    func setupViews(){
        
        let rightButton = UIBarButtonItem(title: "F",
                                          style: UIBarButtonItem.Style.plain ,
                                          target: self, action: #selector(MTAHome.onFilterClicked))
        
        rightButton.tintColor = .black
        
        self.navigationItem.rightBarButtonItem = rightButton
        
        disableFilter()
        
        var margins = view.layoutMarginsGuide

        if #available(iOS 11.0, *) {
            margins = view.safeAreaLayoutGuide
        }
        
        self.view.backgroundColor = .white
        

        self.view.addSubview(svCategory)
        
        svCategory.translatesAutoresizingMaskIntoConstraints = false
        svCategory.topAnchor.constraint(equalTo: margins.topAnchor, constant: 10).isActive = true
        svCategory.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 10).isActive = true
        svCategory.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: -10).isActive = true
        svCategory.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(vSeachPanel)
        
        vSeachPanel.translatesAutoresizingMaskIntoConstraints = false
        vSeachPanel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 70).isActive = true
        vSeachPanel.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0).isActive = true
        vSeachPanel.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0).isActive = true
        vSeachPanel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        self.vSeachPanel.addSubview(txtSearch)
        
        txtSearch.translatesAutoresizingMaskIntoConstraints = false
        txtSearch.topAnchor.constraint(equalTo: vSeachPanel.layoutMarginsGuide.topAnchor, constant: 2).isActive = true
        txtSearch.leftAnchor.constraint(equalTo: vSeachPanel.layoutMarginsGuide.leftAnchor, constant: 5).isActive = true
        txtSearch.rightAnchor.constraint(equalTo: vSeachPanel.layoutMarginsGuide.rightAnchor, constant: -80).isActive = true
        txtSearch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.vSeachPanel.addSubview(btnSearch)
        
        btnSearch.translatesAutoresizingMaskIntoConstraints = false
        btnSearch.topAnchor.constraint(equalTo: vSeachPanel.layoutMarginsGuide.topAnchor, constant: 0).isActive = true
        btnSearch.widthAnchor.constraint(equalToConstant: 70).isActive = true
        btnSearch.rightAnchor.constraint(equalTo: vSeachPanel.layoutMarginsGuide.rightAnchor, constant: -5).isActive = true
        btnSearch.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 120).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tableView.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0).isActive = true
 
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(MTACustomMovieTableCell.self, forCellReuseIdentifier: cellId)
 
        self.view.addSubview(loader)
        
        loader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loader.widthAnchor.constraint(equalToConstant: 50).isActive = true
        loader.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        loader.isHidden = true
        
        
        self.view.addSubview(vPreview)
        
        vPreview.translatesAutoresizingMaskIntoConstraints = false
        vPreview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        vPreview.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0).isActive = true
        vPreview.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0).isActive = true
        vPreview.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        vPreview.addSubview(imgPoster)
        vPreview.addSubview(lblTitle)
        vPreview.addSubview(lblOverview)
        vPreview.addSubview(btnClosePreview)
    }
    
    func setupActions(){
        svCategory.addTarget(self, action: #selector(self.changeCategory(sender:)), for: .valueChanged)
        btnSearch.addTarget(self, action: #selector(self.searchWithText(sender:)), for: .touchUpInside)
        btnClosePreview.addTarget(self, action: #selector(self.closePreview(sender:)), for: .touchUpInside)
    }
    
    @objc func closePreview(sender: UIButton){
        vPreview.isHidden = true
    }
    
    
    
    func fetchData(text: String){
        self.loader.isHidden = false
        self.loader.startAnimating()
        MTAMovieLoader.shared.fetchMovies(kind: category!, page: page!, text: text){
            (result: [Movie], success) in
            if (success){
                if (self.movies.count > 0){
                    if self.isSearching! {
                        self.movies = result
                        self.tableView.reloadData()
                    }
                    else if self.isLoading! {
                        self.movies.append(contentsOf: result)
                        self.tableView.reloadData()
                    }
                    else{
                         self.movies = result
                         self.tableView.reloadData()
                    }
                }
                else{
                    self.movies = result
                    self.tableView.reloadData()
                }
                self.isFiltered = false
            }
            self.loader.stopAnimating()
            self.loader.isHidden = true
            self.isLoading = false
            self.isSearching = false
        }
    }
    
    
    func enableFilter(){
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func disableFilter(){
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.tintColor = .clear
    }
    
    @objc func changeCategory(sender: UISegmentedControl) {
        let isConnected = MTAReachability.shared.isConnected()
        if isConnected{
            self.txtSearch.text = ""
        }

        disableFilter()
        
        txtSearch.resignFirstResponder()
        switch sender.selectedSegmentIndex {
            case 0:
                self.category = 1
                self.isFiltered = false
            case 1:
                self.category = 2
                self.isFiltered = false
            case 2:
                self.category = 3
                enableFilter()
            default:
                self.category = 1
        }
        page = 1
        fetchData(text:txtSearch.text!)
    }
    
    @objc func searchWithText(sender: UIButton){
        let isConnected = MTAReachability.shared.isConnected()
        if isConnected{
            svCategory.selectedSegmentIndex = UISegmentedControl.noSegment
        }
        txtSearch.resignFirstResponder()
        self.isSearching = true
        fetchData(text: txtSearch.text!)
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        var numberOfSections = isFiltered! ? self.filteredMovies.count : self.movies.count
 
        if numberOfSections > 0
        {
            numberOfSections = 1
            tableView.separatorStyle = .singleLine
            tableView.backgroundView = nil
        }
        else
        {
            let noDataLabel: UILabel  = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = isLoading! ? "" : "No Matching Results"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
        }
        return numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered!{
            return  self.filteredMovies.count
        }
        else{
            return  self.movies.count
        }
       
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieTableViewCell", for: indexPath) as! MTACustomMovieTableCell

        let movie = isFiltered! ? filteredMovies[indexPath.row] : movies[indexPath.row]
        
        if  ((movie.posterPath) != nil){
            let url = URL(string: baseURL + movie.posterPath!)
            let placeholderImage = UIImage(named: "movieplaceholder")!
            
            cell.imgMoviePoster.sd_imageTransition = .fade
            cell.imgMoviePoster.sd_internalSetImage(with: url, placeholderImage: placeholderImage, operationKey: nil, setImageBlock: nil, progress: nil)
        }
        else{
            cell.imgMoviePoster.image = UIImage.init(named: "movieplaceholder")
        }
        
        cell.btFavoriteMovie.tag = indexPath.row
        
        let image = isFavorite(movie: movie) ? UIImage(named: "heart") : UIImage(named: "unheart")
        cell.btFavoriteMovie.setImage(image, for: .normal)

        cell.lblMovieTitle.text = movie.title
        cell.lblMovieOverview.text = movie.overview
        return cell
    }
    
    func isFavorite(movie: Movie) -> Bool {
        let movieID = movie.id
        let movieStorage = MTAMovieStorage.shared
        movieStorage.loadDataFromFile()
        let movies = movieStorage.retrieveArray(category: "favorites")
        for mov in movies{
            if mov.id == movieID{
                return true
            }
        }
        return false
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let targetController =  MTAMovieDetailedViewController()
        targetController.movie = movie
        targetController.delegate = self
        self.navigationController?.pushViewController(targetController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let lastElement = movies.count - 1
            let isConnected = MTAReachability.shared.isConnected()
            if !(isLoading!) && (indexPath.row == lastElement) && movies.count > 19 && isConnected  {
                isLoading = true
                page = page! + 1
                
                fetchData(text: txtSearch.text!)
            }

    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            let movie = movies[indexPath.row]
            MTAMovieStorage.shared.deleteFavoriteFromFile(id: "\(movie.id)")
            movies.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .left)
            tableView.endUpdates()
        }
    }


}

