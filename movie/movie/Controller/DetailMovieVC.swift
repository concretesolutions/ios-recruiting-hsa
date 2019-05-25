//
//  DetailMovieVC.swift
//  movie
//
//  Created by ely.assumpcao.ndiaye on 23/05/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class DetailMovieVC: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var dateMovie: UILabel!
    @IBOutlet weak var genersTxt: UILabel!
    @IBOutlet weak var descriptionTxt: UITextView!
    
    var titulo: String!
    var descricao: String!
    var imagem: String!
    var dataMovie: String!
    var genero: String!
    
    func initData(title: String, description: String, image: String, date: String, geners: String) {
        self.titulo = title
        self.descricao = description
        self.imagem = image
        self.dataMovie = date
        self.genero = geners
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleMovie.text = titulo
        genersTxt.text = genero
        dateMovie.text = dataMovie
        genersTxt.text = genero
        descriptionTxt.text = descricao
        
        
        
        let pathImage = String(imagem) ?? ""
        let Image = "\(URL_IMG)\(pathImage)" ?? ""
        print (Image)
        let url = URL(string: Image)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            movieImage.image = UIImage(data: imageData)
        }

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
}
