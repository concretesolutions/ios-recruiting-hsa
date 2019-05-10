//
//  MTAHome.swift
//  MovieApp
//
//  Created by Andres Ortiz on 4/17/19.
//  Copyright © 2019 Andres. All rights reserved.
//


import UIKit

class MTAHome: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let cellId = "CustomMovieTableViewCell"
    
    var isSearching: Bool?
    var isLoading: Bool?
    var page: Int?
    var movies = [Movie]()
    var category : Int?
    let tableView: UITableView = UITableView()
    
    
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .whiteLarge)
        loader.color = .black
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    let svCategory : UISegmentedControl = {
        let items = ["Popular", "Top Rated"]
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func setupViews(){
        
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
            }
            self.loader.stopAnimating()
            self.loader.isHidden = true
            self.isLoading = false
            self.isSearching = false
        }
    }
    
    

    
    @objc func changeCategory(sender: UISegmentedControl) {
        let isConnected = MTAReachability.shared.isConnected()
        if isConnected{
            self.txtSearch.text = ""
        }

        txtSearch.resignFirstResponder()
        switch sender.selectedSegmentIndex {
            case 0:
                self.category = 1;
            case 1:
                self.category = 2;
            default:
                self.category = 1;
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
        var numOfSections: Int = 0
        if self.movies.count > 0
        {
            tableView.separatorStyle = .singleLine
            numOfSections            = 1
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
        return numOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.movies.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMovieTableViewCell", for: indexPath) as! MTACustomMovieTableCell

        let movie = movies[indexPath.row]
        
        
        if  ((movie.posterPath) != nil){
            let url = URL(string: baseURL + movie.posterPath!)
            let placeholderImage = UIImage(named: "movieplaceholder")!
            
            cell.imgMoviePoster.sd_imageTransition = .fade
            cell.imgMoviePoster.sd_internalSetImage(with: url, placeholderImage: placeholderImage, operationKey: nil, setImageBlock: nil, progress: nil)
        }
        else{
            cell.imgMoviePoster.image = UIImage.init(named: "movieplaceholder")
        }
        
        cell.btMoviePreview.tag = indexPath.row
        cell.btMoviePreview.addTarget(self, action: #selector(self.openPreview(sender:)), for: .touchUpInside)

        cell.lblMovieTitle.text = movie.title
        cell.lblMovieOverview.text = movie.overview
        return cell
    }
    
    @objc func openPreview(sender: UIButton){
        vPreview.isHidden = false
        let movie = movies[sender.tag]
        
        
        if  ((movie.posterPath) != nil){
            let url = URL(string: baseURL + movie.posterPath!)
            let placeholderImage = UIImage(named: "movieplaceholder")!
            imgPoster.sd_imageTransition = .fade
            imgPoster.sd_internalSetImage(with: url, placeholderImage: placeholderImage, operationKey: nil, setImageBlock: nil, progress: nil)
        }
        else{
            imgPoster.image = UIImage.init(named: "movieplaceholder")
        }
        
        lblTitle.text = movie.title
        lblOverview.text = movie.overview
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let targetController =  MTAMovieDetailedViewController()
        targetController.movie = movie
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


}

