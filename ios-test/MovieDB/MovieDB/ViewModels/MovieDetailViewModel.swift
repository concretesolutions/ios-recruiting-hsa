//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/8/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    private var networking = Network()
    var genres: String? {
        didSet {
            guard genres != nil else { return }
            didFinishFetch?()
        }
    }

    var id: String

    var error: Error? {
        didSet { showAlertClosure?() }
    }

    init(movieID: String!) {
        self.id = movieID
    }

    var showAlertClosure: (() -> Void)?
    var didFinishFetch: (() -> Void)?

    /// Fetch all movies from API
    func fetchMovie() {
        let requestURL = URL(string: "https://api.themoviedb.org/3/movie/\(self.id)?api_key=16e1fc6c05c67098e7f7f5c8b4ff6528&language=en-US")!
        networking.fetchData(url: requestURL, completion: { (response: MovieDetailResponse?, error: DataManagerError) in
            DispatchQueue.main.async {
                if error != .noErrors {
                    return
                }
                self.genres = response?.genres.map { "\($0.name)" }.joined(separator: " , ")
            }
        })
    }

    func getGenres() -> MovieCellRows {
        return MovieCellRows(text: self.genres ?? "N/A", rowType: .isText)
    }
}
