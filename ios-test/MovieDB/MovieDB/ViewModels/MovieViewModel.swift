//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/6/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import CoreData
import Foundation
import UIKit

class MovieViewModel {
    private var networking = Network()
    var movieArray: [MovieViewModel]? {
        didSet {
            guard movieArray != nil else { return }
            didFinishFetch?()
        }
    }

    let id: String
    let originalTitle: String
    let posterPath: String
    let overview: String
    let releaseDate: String

    var error: Error? {
        didSet { showAlertClosure?() }
    }

    var isLoading: Bool = false {
        didSet { updateLoadingStatus?() }
    }

    init(model: Movies?) {
        posterPath = model?.posterPath ?? "a4BfxRK8dBgbQqbRxPs8kmLd8LG.jpg"
        originalTitle = model?.originalTitle ?? "Title Name Not Available"
        id = String(model?.id ?? 0)

        let dateString = model?.releaseDate.components(separatedBy: "-")
        releaseDate = dateString?[0] ?? "-"
        overview = model?.overview ?? "No Available Description"
    }

    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    var didFinishFetch: (() -> Void)?
    var didDeleteMovie: (() -> Void)?
    var didAddMovie: (() -> Void)?
    var didSearchMovie: (() -> Void)?

    /// Fetch all movies from API
    func fetchMovies() {

        isLoading = true
        let requestURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=16e1fc6c05c67098e7f7f5c8b4ff6528&language=en-US&page=1")!

        networking.fetchData(url: requestURL, completion: { (response: MoviePopularResponse?, error: DataManagerError) in
            DispatchQueue.main.async {
                self.isLoading = false

                if error != .noErrors {
                    return
                }

                //  Convert Response to ViewModelArray
                if !(response?.results.isEmpty)! {
                    var tmpArray = [MovieViewModel]()
                    response?.results.forEach({
                        tmpArray.append(MovieViewModel(model: $0))
                    })
                    self.movieArray = tmpArray
                } else {
                    print(DataManagerError.emptyResponse.localizedDescription)
                }

                self.didFinishFetch?()
            }
        })
    }

    func saveFavorite(viewModel: MovieViewModel!) -> Bool {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let userEntity = NSEntityDescription.entity(forEntityName: "Favorites", in: managedContext)!

        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(Int(viewModel.id), forKeyPath: "id")
        user.setValue(viewModel.originalTitle, forKey: "originalTitle")
        user.setValue(viewModel.posterPath, forKey: "posterPath")
        user.setValue(viewModel.overview, forKey: "overview")
        user.setValue(viewModel.releaseDate, forKey: "releaseDate")

        do {
            try managedContext.save()
            return true
        } catch {
            return false
        }
    }

    func getFavorites() -> [MovieViewModel] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        var movieArray = [MovieViewModel]()

        do {
            let result = try managedContext.fetch(fetchRequest)

            for data in result as! [NSManagedObject] {
                let movieID = data.value(forKey: "id") as! Int
                let title = data.value(forKey: "originalTitle") as! String
                let posterPath = data.value(forKey: "posterPath") as! String
                let overview = data.value(forKey: "overview") as! String
                let releaseDate = data.value(forKey: "releaseDate") as! String

                let movieModel = Movies(id: movieID,
                                        originalTitle: title,
                                        posterPath: posterPath,
                                        overview: overview,
                                        releaseDate: releaseDate)

                let viewModel = MovieViewModel(model: movieModel)
                movieArray.append(viewModel)
            }
            return movieArray
        } catch {
            return movieArray
        }
    }

    func searchByFilter(releaseDate: String, genre: String) -> [MovieViewModel] {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchRequest.predicate = NSPredicate(format: "releaseDate = %@ AND genre = %@", releaseDate, genre)

        var movieArray = [MovieViewModel]()

        do {
            let result = try managedContext.fetch(fetchRequest)

            for data in result as! [NSManagedObject] {
                let movieID = data.value(forKey: "id") as! Int
                let title = data.value(forKey: "originalTitle") as! String
                let posterPath = data.value(forKey: "posterPath") as! String
                let overview = data.value(forKey: "overview") as! String
                let releaseDate = data.value(forKey: "releaseDate") as! String

                let movieModel = Movies(id: movieID,
                                        originalTitle: title,
                                        posterPath: posterPath,
                                        overview: overview,
                                        releaseDate: releaseDate)

                let viewModel = MovieViewModel(model: movieModel)
                movieArray.append(viewModel)
            }
            return movieArray
        } catch {
            return movieArray
        }
    }

    func searchFavorite(viewModel: MovieViewModel!) -> Bool {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchRequest.predicate = NSPredicate(format: "originalTitle = %@", viewModel.originalTitle)
        fetchRequest.returnsObjectsAsFaults = false

        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count == 1 {
                return false
            } else {
                return true
            }
        } catch {
            return false
        }

    }

    func removeFavorite(viewModel: MovieViewModel!) -> Bool {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        fetchRequest.predicate = NSPredicate(format: "id = %@", viewModel.id)

        do {
            let movie = try managedContext.fetch(fetchRequest)
            let objectToDelete = movie[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do {
                try managedContext.save()
                return true
            } catch {
                return false
            }
        } catch {
            return false
        }
    }

    func detailRows(viewModel: MovieViewModel) -> [MovieCellRows] {

        var movieRows = [MovieCellRows]()
        movieRows.append(MovieCellRows(text: viewModel.posterPath, rowType: .isImage))
        movieRows.append(MovieCellRows(text: viewModel.originalTitle, rowType: .isText))
        movieRows.append(MovieCellRows(text: viewModel.releaseDate, rowType: .isText))
        movieRows.append(MovieCellRows(text: "Loading Genres...", rowType: .isText))
        movieRows.append(MovieCellRows(text: viewModel.overview, rowType: .isText))
        return movieRows
    }
}
