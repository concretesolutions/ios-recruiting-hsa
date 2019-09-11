//
//  GenreViewModel.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/8/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation

class GenreViewModel {
    private var networking = Network()
    var genreArray: [GenreDictionary]? {
        didSet {
            guard genreArray != nil else { return }
            didFinishFetch?()
        }
    }

    var error: Error? {
        didSet { showAlertClosure?() }
    }

    var isLoading: Bool = false {
        didSet { updateLoadingStatus?() }
    }

    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var didFinishFetch: (() -> Void)?

    func fetchGenres() {

        isLoading = true
        let requestURL = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=16e1fc6c05c67098e7f7f5c8b4ff6528&language=en-US")!

        networking.fetchData(url: requestURL, completion: { (response: GenreListResponse?, error: DataManagerError) in
            DispatchQueue.main.async {

                self.isLoading = false

                if error != .noErrors {
                    return
                }

                //  Convert Response to ViewModelArray
                if !(response?.genres.isEmpty)! {
                    self.genreArray = response?.genres
                } else {
                    print(DataManagerError.emptyResponse.localizedDescription)
                }

                self.didFinishFetch?()
            }
        })
    }
}
