//
//  MovieDetailViewController.swift
//  concreteMovieData
//
//  Created by Christopher Parraguez on 9/5/19.
//  Copyright © 2019 Christopher Parraguez. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var detailMovie: UIImageView!
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var yearMovie: UILabel!
    @IBOutlet weak var genreMovie: UILabel!
    @IBOutlet weak var overviewMovie: UILabel!
    var idMovie: String!
    var movie: DetailMovie!
    override func viewDidLoad() {
        super.viewDidLoad()
        callDetailMovie()
        // Do any additional setup after loading the view.
    }
    
    func callDetailMovie(){
        let url = URL(string: BASEURL + MOVIE + "/" + idMovie)
        let params = ["api_key":APIKEY, "language":"es-ES"] as [String : Any]
        Alamofire.request(url!, method: .get, parameters: params)
            .responseObject { (response: DataResponse<DetailMovie>) in
                switch(response.result){
                case .success(_):
                    self.movie = response.result.value
                    if self.movie != nil{
                        self.detailMovie.dowloadFromServer(link: BASE_IMAGE_DETAIL_URL+self.movie.poster_path!, contentMode: .scaleToFill)
                        self.nameMovie.text = self.movie.original_title
                        self.genreMovie.text = self.movie.genresString()
                        self.yearMovie.text = self.movie.getYearToDateString()
                        self.overviewMovie.text = self.movie.overview
                    }else{
                        let alert = UIAlertController(title: "Alerta", message: "No existen resultados a la busqueda", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true)
                    }
                    break

                case .failure(let error):
                    let alert = UIAlertController(title: "ERROR", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    break
                }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//extension UIImageView {
//    func dowloadFromServer2(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                else { return }
//            DispatchQueue.main.async() {
//                self.image = image
//            }
//            }.resume()
//    }
//    func dowloadFromServer2(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
//        guard let url = URL(string: link) else { return }
//        dowloadFromServer(url: url, contentMode: mode)
//    }
//}
