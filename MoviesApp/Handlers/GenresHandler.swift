//
//  GenresHandler.swift
//  MoviesApp
//
//  Created by Hector Morales on 2/28/21.
//

import Foundation

protocol GenresHandlerProtocol: class {
    func gotGenres(items: [Genre])
    func gotGenresError()
}

class GenresHandler {

    weak var dataSourceProtocol: GenresHandlerProtocol?

    init(dataSource: GenresHandlerProtocol) {
        self.dataSourceProtocol = dataSource

    }

    init() {
        getGenres()
    }

    func getGenres() {
        GenreServices.getGenres(successBlock: { [weak self] response in
            self?.dataSourceProtocol?.gotGenres(items: response)
            self?.saveInCache(items: response)
        }, errorBlock: {
            self.dataSourceProtocol?.gotGenresError()
        })
    }

    private func saveInCache(items: [Genre]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: UserDefaultsKeys.genresArrayCache)
        }
    }

    static func loadGenresFromCache() -> [Genre]? {
        if let savedGenres = UserDefaults.standard.object(forKey: UserDefaultsKeys.genresArrayCache) as? Data {
            let decoder = JSONDecoder()
            if let loadedGenres = try? decoder.decode([Genre].self, from: savedGenres) {
                return loadedGenres
            }
        }
        return nil
    }

    static func getGenresById(genresId: [Int]?) -> String {
        var genresString: String = ""
        guard let genresId = genresId else { return genresString }
        if let genresArray = loadGenresFromCache() {
            for genre in genresId {
                if let name = genresArray.first(where: {$0.id == genre})?.name{
                    genresString += "\(name)  "
                }
            }
        }
        return genresString
    }

}
