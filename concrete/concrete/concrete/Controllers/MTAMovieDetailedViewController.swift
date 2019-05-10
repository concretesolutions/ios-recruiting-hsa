//
//  MovieDetailedViewController.swift
//  MovieApp
//
//  Created by Andres Ortiz on 4/17/19.
//  Copyright © 2019 Andres. All rights reserved.
//


import UIKit
import SDWebImage
import YouTubePlayer


class MTAMovieDetailedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, YouTubePlayerDelegate {

    var movie: Movie?
    var videoURL: String?
    var aiLoader: UIActivityIndicatorView?
    let tvMovie = UITableView()
    
    @objc func goBackAction(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    func playerReady(_ videoPlayer: YouTubePlayer.YouTubePlayerView) {
        self.aiLoader?.stopAnimating()
        self.aiLoader?.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = movie!.title
        self.tvMovie.backgroundColor = .black
        self.tvMovie.delegate = self
        self.tvMovie.dataSource = self
        self.videoURL = ""
        self.aiLoader = UIActivityIndicatorView()
        self.aiLoader?.startAnimating()
        self.aiLoader?.tintColor = UIColor.white
        self.tvMovie.separatorStyle = .none
        
        setupViews()
        fetchMovieVideo()
    }

    func setupViews(){
        var margins = view.layoutMarginsGuide
        
        if #available(iOS 11.0, *) {
            margins = view.safeAreaLayoutGuide
        }
        
        self.view.backgroundColor = .black

        self.view.addSubview(tvMovie)
        
        tvMovie.translatesAutoresizingMaskIntoConstraints = false
        tvMovie.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0).isActive = true
        tvMovie.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tvMovie.leftAnchor.constraint(equalTo: margins.leftAnchor, constant: 0).isActive = true
        tvMovie.rightAnchor.constraint(equalTo: margins.rightAnchor, constant: 0).isActive = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchMovieVideo(){
        MTAMovieLoader.shared.fetchMovieVideo(movieId: (self.movie?.id)!){
            (result: String, success) in
            self.videoURL = result
            self.tvMovie.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat
        switch indexPath.row {
        case 0:
            height = videoZoneHeigth
        case 1:
            height = 80.0
        case 2:
            height = CGFloat(UIScreen.main.bounds.height/3)
        case 3:
            height = 80.0
        default:
            height = 0.0
        }

        return height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        switch indexPath.row {
        case 0:
            let isConnected = MTAReachability.shared.isConnected()
            if isConnected{
                if (self.videoURL != "")
                {
                    let videoPlayer = YouTubePlayerView(frame: CGRect(x:0, y:0, width: UIScreen.main.bounds.width, height: videoZoneHeigth))
                    videoPlayer.loadVideoID(self.videoURL!)
                    videoPlayer.backgroundColor = UIColor.black
                    videoPlayer.delegate = self
                    cell.addSubview(videoPlayer)
                    self.aiLoader?.frame = CGRect(x:  CGFloat(UIScreen.main.bounds.width/2)-10, y: CGFloat(videoZoneHeigth/2)-10, width: 20, height: 20)
                    cell.addSubview(self.aiLoader!)
                    cell.bringSubviewToFront(self.aiLoader!)
                }
                else{
                    let lblTitle = UILabel()
                    lblTitle.frame = CGRect(x: 0, y: CGFloat(UIScreen.main.bounds.width/2)-30, width: UIScreen.main.bounds.width, height: 20)
                    lblTitle.backgroundColor = UIColor.black
                    lblTitle.textColor = UIColor.white
                    lblTitle.textAlignment = .center
                    lblTitle.text = "Loading"
                    cell.addSubview(lblTitle)
                }

            }
            else{
                let lblTitle = UILabel()
                lblTitle.frame = CGRect(x: 0, y: CGFloat((videoZoneHeigth/2)-30), width: UIScreen.main.bounds.width, height: 20)
                lblTitle.text = "No video available without connection"
                lblTitle.lineBreakMode = .byWordWrapping
                lblTitle.font = UIFont.systemFont(ofSize: 20, weight: .thin)
                lblTitle.numberOfLines = 0
                lblTitle.backgroundColor = UIColor.black
                lblTitle.textColor = UIColor.white
                lblTitle.textAlignment = .center
                cell.backgroundColor = UIColor.black
                cell.addSubview(lblTitle)
            }

            cell.backgroundColor = UIColor.black
            
        case 1:
            let lblTitle = UILabel()
            lblTitle.frame = CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 10, height: cell.frame.height)
            lblTitle.text = movie!.title
            lblTitle.font = UIFont.systemFont(ofSize: 22, weight: .thin)
            lblTitle.numberOfLines = 0
            lblTitle.backgroundColor = UIColor.black
            lblTitle.textColor = UIColor.white
            cell.backgroundColor = UIColor.black
            cell.addSubview(lblTitle)
            
            let lblReleaseDate = UILabel()
            lblReleaseDate.frame = CGRect(x: 10, y: 40, width: halfScreenWidth - 10, height: 20)
            lblReleaseDate.text = "Release \(movie?.releaseDate ?? "No register")"
            lblReleaseDate.lineBreakMode = .byWordWrapping
            lblReleaseDate.font = UIFont.systemFont(ofSize: 14, weight: .thin)
            lblReleaseDate.numberOfLines = 0
            lblReleaseDate.backgroundColor = UIColor.black
            lblReleaseDate.textColor = UIColor.groupTableViewBackground
            lblReleaseDate.textAlignment = .left

            cell.addSubview(lblReleaseDate)
            
            let lblRating = UILabel()
            lblRating.frame = CGRect(x: halfScreenWidth, y: 40, width: halfScreenWidth - 30, height: 20)
            lblRating.text = "Rate (\(movie?.voteAverage ?? 0.0))"
            lblRating.lineBreakMode = .byWordWrapping
            lblRating.font = UIFont.systemFont(ofSize: 14, weight: .thin)
            lblRating.numberOfLines = 0
            lblRating.backgroundColor = UIColor.black
            lblRating.textColor = UIColor(red: 238.0, green: 145.0, blue: 30.0, alpha: 1.0)
            lblRating.textAlignment = .right
            
            cell.addSubview(lblRating)
            
            let imgRating = UIImageView()
            imgRating.frame = CGRect(x: (UIScreen.main.bounds.width - 28), y: 40, width: 20, height: 20)
            imgRating.image = UIImage(named: "star")
            cell.addSubview(imgRating)
            
            
            cell.backgroundColor = UIColor.black
        case 2:
            let imgCover : UIImageView
            imgCover = UIImageView()
            imgCover.frame = CGRect(x:20, y: 10, width: (UIScreen.main.bounds.width/3), height: (UIScreen.main.bounds.height/3)-20)
            imgCover.contentMode = .scaleAspectFit
            if ((movie!.posterPath) != nil){
                let placeholderImage = UIImage(named: "movieplaceholder")!
                imgCover.sd_setImage(with: URL(string: baseURL + movie!.posterPath!), placeholderImage:  placeholderImage)
            }
            else{
               imgCover.image = UIImage.init(named: "movieplaceholder")
            }
            cell.addSubview(imgCover)
            
            let lblPlot = UILabel()
            lblPlot.frame = CGRect(x: (UIScreen.main.bounds.width/3
                ) + 40, y: 0, width: (UIScreen.main.bounds.width * 0.66666) - 50, height: UIScreen.main.bounds.height/3)
            lblPlot.text = movie!.overview
            lblPlot.textAlignment = .justified
            lblPlot.font = UIFont.systemFont(ofSize: 15, weight: .thin)
            lblPlot.numberOfLines = 0
            lblPlot.backgroundColor = UIColor.clear
            lblPlot.textColor = UIColor.white
            cell.backgroundColor = UIColor.black
            cell.addSubview(lblPlot)
        case 3:
            let btBuyIt = UIButton()
            btBuyIt.frame = CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height:cell.frame.height)
            btBuyIt.layer.masksToBounds = true
            btBuyIt.layer.cornerRadius = 5
            btBuyIt.setTitle("Buy It", for: .normal)
            btBuyIt.backgroundColor = UIColor.red
            btBuyIt.addTarget(self, action: #selector(self.doBuyIt(_:)), for: UIControl.Event.touchUpInside)
            cell.backgroundColor = UIColor.black
            cell.addSubview(btBuyIt)
        default:
            cell.textLabel?.text = "nothing"
        }
        return cell
    }
    
    @objc func doAddToTheList(_ sender: UIButton){
        
    }
    
    @objc func doBuyIt(_ sender: UIButton){
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
