//
//  Genres.swift
//  movs
//
//  Created by Carlos Petit on 15-03-21.
//

import Foundation
import UIKit

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]
}

// MARK: Genres convenience initializers and mutators

extension Genres {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Genres.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        genres: [Genre]? = nil
    ) -> Genres {
        return Genres(
            genres: genres ?? self.genres
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: Genre convenience initializers and mutators

extension Genre {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(Genre.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        id: Int? = nil,
        name: String? = nil
    ) -> Genre {
        return Genre(
            id: id ?? self.id,
            name: name ?? self.name
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

protocol GenresViewModeldelegate {
    func reloadData()
}



class GenresViewModel {
    private var itemsGenre: [Genres] = []
    
    var numbersOfItems: Int{
        return itemsGenre.count
    }
    var delegate: GenresViewModeldelegate?
    init (){
        getData()
      }
    @objc private func getData() {
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=8ac7358ab8ca29d459c647efc5664fae&language=en-US") else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("api_key", forHTTPHeaderField: "8ac7358ab8ca29d459c647efc5664fae")


            URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    if let error = error {
                        print("Error",error.localizedDescription)
                        return
                    }
                    self.itemsGenre.removeAll()
                    let decoder = JSONDecoder()
                    
                    let response = try decoder.decode(Genres.self, from: data!)
                    print(response)
                    self.itemsGenre.append(response)
                   

                } catch { print("Errorsssds",error) }
                
            }.resume()
     
     }
    
    func item(at indexPath:IndexPath) -> GenreViewModel {
        return GenreViewModel(genre: itemsGenre[0].genres[indexPath.row])
    }
    
    func item(at indexPath:Int) -> GenreViewModel {
        return GenreViewModel(genre: itemsGenre[0].genres[indexPath])
    }
    
    func getGenres(ids: [Int]) -> String {
        var idsValues: [String] = []
        for id in ids {
            for genre: Genre in itemsGenre.first?.genres ?? [] {
                if id == genre.id {
                    idsValues.append(genre.name)
                }
            }
        }
        return idsValues.joined(separator: ", ")
    }
    
}


class GenreViewModel {
    
    private var genre:Genre
    
    var name: String {
        return genre.name
    }
    var id: Int {
        return genre.id
    }
    
    init(genre: Genre) {
        self.genre = genre
    }
}
