//
//  MovieDetailViewController.swift
//  tmdb-app
//
//  Created by training on 02-07-22.
//

import Foundation
import UIKit
import Alamofire

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
class MovieDetailViewController: UIViewController {
    
    var movieDetail: MovieDetail!
    var movieId: String!
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var spinnerNew: UIActivityIndicatorView!
    var contadorGlobal:Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupView()
        
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//
//        createTimer()
//    }
    
    func setupView() {
        
        guard let movId = movieId else {
            return
        }
        
        let movieDetEnd = Endpoints.movieDetail.replacingOccurrences(of: ":movieId", with: movId)
    
        print("movie_detail_endpoint: \(movieDetEnd)")
        AF.request(movieDetEnd).response {
            response in
            
            if response.error != nil {
                print("internal server error")
                return
            }

            guard let data = response.data else {
                print("not found")
                return
            }
            
            print("before decode")
            //print("data: \(data)")
            
            do {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(MovieDetail.self, from: data)
                
                print("response: \(response)")
                
                self.movieDetail = response
                
                if let urlImg : String = self.movieDetail.backdropPath {
                    self.movieImage.downloaded(from: Endpoints.imageBasePath + urlImg)
                    self.movieImage.contentMode = .scaleAspectFill
                    
                }
            
                self.movieName.text = self.movieDetail.title
                self.movieOverview.text = self.movieDetail.overview
                self.movieYear.text = self.getYearAsString(strDate: self.movieDetail.releaseDate!)
                self.movieGenre.text = self.namesToString(arr: self.movieDetail.genres!)

            } catch let error {
                
                let alert = UIAlertController(title: "Movie Detail", message: "Ha ocurrido un error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok" , style: .default, handler: { action in
                    switch action.style{
                        case .default:
                            print(error)
                        
                        case .cancel:
                            print("")
                            
                        case .destructive:
                            print("")
                            
                        @unknown default:
                            print("")
                        
                    }
                }))
                self.present(alert, animated: true, completion: nil)
                
               
            }
        }
        
    }
    
    func namesToString(arr: [Genre]?) -> String {
        var results: [String] = []
        if let genres = arr {
            for genre in genres {
                if genre.name != nil {
                    results.append(genre.name!)
                }
            }
            return results.joined(separator: ", ")
        }
        return ""
    }
    
    func getYearAsString(strDate: String?) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd"
        let date = dateFormatter.date(from: strDate!)
        
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date!)
        
        return yearString
        
    }
    
//    func createTimer(){
//
//        spinnerIngreso.isHidden = false
//        spinnerIngreso.startAnimating()
//
//        let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: false)
//
//        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
//            timer.fire()
//        }
//    @objc func fireTimer() {
//
//        spinnerNew.hidesWhenStopped = true
//        spinnerNew.stopAnimating()
//
//    }
}


