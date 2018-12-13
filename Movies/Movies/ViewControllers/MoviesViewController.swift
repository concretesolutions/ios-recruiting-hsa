//
//  ViewController.swift
//  Movies
//
//  Created by Consultor on 12/12/18.
//  Copyright © 2018 Mavzapps. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let network = NetworkAPIManager()
        let params = ["api_key":network.apiKey,"page":1] as [String : Any]
        network.request(urlString: "movie/popular", params: params)
    }


}

