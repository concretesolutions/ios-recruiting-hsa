//
//  FilterDetailPresenter.swift
//  MoviesApp
//
//  Created by gustavo.salazar on 21/06/22.
//

import Foundation

protocol FilterDtlPresenterDelegate: AnyObject {
    func presentDate(years: [Int])
    func presentGenres(genres: [Genre])
    func showError(error: Error)
}

typealias PresenterFilterDtlDelegate = FilterDtlPresenterDelegate

// MARK: -
class FilterDtlPresenter {
    weak var delegate: PresenterFilterDtlDelegate?
    let years: [Int] = [2017, 2018, 2019, 2020, 2021, 2022]

    public func setViewDelegate(delegate: PresenterFilterDtlDelegate) {
        self.delegate = delegate
    }

    func getDate() {
        self.delegate?.presentDate(years: years)
    }

    func getGenres() {
        guard let url = URL(string: APIUrl.genresURL) else {return}
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                self.delegate?.showError(error: UrlFail.fail)
                return
            }
            do {
                let genresData = try JSONDecoder().decode(Genres.self, from: data)
                self.delegate?.presentGenres(genres: genresData.genres)
            } catch {
                self.delegate?.showError(error: error)
            }
        }
        task.resume()
    }
}
