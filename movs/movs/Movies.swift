//
//  Movies.swift
//  movs
//
//  Created by Carlos Petit on 13-03-21.
//

import UIKit



protocol MoviesViewModeldelegate {
    func reloadData()
}


protocol FavoritesMoviesViewModeldelegate {
    func reloadData()
}


var items: [ResponseMovies] = []
var favItems: [Movie] = []



// MARK: - ResponseMovies
class ResponseMovies: Codable {
    let page: Int
    var results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(page: Int, results: [Movie], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

// MARK: Welcome convenience initializers and mutators

extension ResponseMovies {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(ResponseMovies.self, from: data)
        self.init(page: me.page, results: me.results, totalPages: me.totalPages, totalResults: me.totalResults)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        page: Int? = nil,
        results: [Movie]? = nil,
        totalPages: Int? = nil,
        totalResults: Int? = nil
    ) -> ResponseMovies {
        return ResponseMovies(
            page: page ?? self.page,
            results: results ?? self.results,
            totalPages: totalPages ?? self.totalPages,
            totalResults: totalResults ?? self.totalResults
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Result
class Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    var isFavorite: Bool? = false

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    init(adult: Bool, backdropPath: String, genreIDS: [Int], id: Int, originalLanguage: String, originalTitle: String, overview: String, popularity: Double, posterPath: String, releaseDate: String, title: String, video: Bool, voteAverage: Double, voteCount: Int, isFavorite: Bool) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}

// MARK: Result convenience initializers and mutators

extension Movie {
    convenience init(data: Data) throws {
        let me = try newJSONDecoder().decode(Movie.self, from: data)
        let isFavorite = false
        self.init(adult: me.adult, backdropPath: me.backdropPath, genreIDS: me.genreIDS, id: me.id, originalLanguage: me.originalLanguage, originalTitle: me.originalTitle, overview: me.overview, popularity: me.popularity, posterPath: me.posterPath, releaseDate: me.releaseDate, title: me.title, video: me.video, voteAverage: me.voteAverage, voteCount: me.voteCount, isFavorite: isFavorite)
    }

    convenience init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    convenience init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        adult: Bool? = nil,
        backdropPath: String? = nil,
        genreIDS: [Int]? = nil,
        id: Int? = nil,
        originalLanguage: String? = nil,
        originalTitle: String? = nil,
        overview: String? = nil,
        popularity: Double? = nil,
        posterPath: String? = nil,
        releaseDate: String? = nil,
        title: String? = nil,
        video: Bool? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil,
        isFavorite: Bool = false
    ) -> Movie {
        return Movie(
            adult: adult ?? self.adult,
            backdropPath: backdropPath ?? self.backdropPath,
            genreIDS: genreIDS ?? self.genreIDS,
            id: id ?? self.id,
            originalLanguage: originalLanguage ?? self.originalLanguage,
            originalTitle: originalTitle ?? self.originalTitle,
            overview: overview ?? self.overview,
            popularity: popularity ?? self.popularity,
            posterPath: posterPath ?? self.posterPath,
            releaseDate: releaseDate ?? self.releaseDate,
            title: title ?? self.title,
            video: video ?? self.video,
            voteAverage: voteAverage ?? self.voteAverage,
            voteCount: voteCount ?? self.voteCount,
            isFavorite: isFavorite
        )
    }

    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}




class MoviesViewModel {
    
    
    var numbersOfItems: Int{
        var _count = 0
        if(items.count > 0){
            _count = items.first?.results.count ?? 0
        }
        return _count
       
    }
    var delegate: MoviesViewModeldelegate?
    init (){
        getData()
      }
    @objc private func getData() {
        if(items.count <= 0) {
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=8ac7358ab8ca29d459c647efc5664fae&language=en-US&page=1") else { return }

                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue("api_key", forHTTPHeaderField: "8ac7358ab8ca29d459c647efc5664fae")


                URLSession.shared.dataTask(with: request) { (data, response, error) in
                    do {
                        if let error = error {
                            print("Error",error.localizedDescription)
                            return
                        }
                        items.removeAll()
                        let decoder = JSONDecoder()
                        
                        let response = try decoder.decode(ResponseMovies.self, from: data!)
                        print(response)
                        items.append(response)
                       

                    } catch { print("Errorsssds",error) }
                    
                }.resume()
        }
        
     
     }
    
    func item(at indexPath:IndexPath) -> MovieViewModel {
        return MovieViewModel(movie: items[0].results[indexPath.row])
    }
    
    func item(at indexPath:Int) -> MovieViewModel {
        return MovieViewModel(movie: items[0].results[indexPath])
    }
    
    func printItems() {
        
    }
    
    func favorite(at indexPath: Int) {
        items[0].results[indexPath].isFavorite = !items[0].results[indexPath].isFavorite!
    }
    
    func remove(at indexPath: IndexPath) {
        items[0].results[indexPath.row].isFavorite = false
    }
}

class FavoritesMoviesViewModel {
    
    
    var numbersOfItems: Int{
        
        return (favItems.count)
    }
    var delegate: FavoritesMoviesViewModeldelegate?
    init (){
        getData()
      }
    @objc private func getData() {
        if(items.count > 0 ){
            favItems = items[0].results.filter{ movie in
                return movie.isFavorite!
            }
        }
        
     }
    
    func item(at indexPath:IndexPath) -> MovieViewModel {
        return MovieViewModel(movie: favItems[indexPath.row])
    }
    
    func item(at indexPath:Int) -> MovieViewModel {
        return MovieViewModel(movie: favItems[indexPath])
    }
    
    func remove(at indexPath: IndexPath) {
        let item = favItems[indexPath.row]
        var copyItems:[Movie] = []
        favItems.remove(at: indexPath.row)
        for items in items[0].results {
            if(items.id == item.id){
                items.isFavorite = false
            }
        }
    }
}


class MovieViewModel {
    
    private var movie:Movie
    
    var title: String{
        return movie.title
    }
    var year: String{
        return movie.releaseDate
    }
    
    var image: URL{
        return URL(string: "https://image.tmdb.org/t/p/w500" + movie.posterPath)!
    }
    
    var favorite: Bool {
        return movie.isFavorite!
    }
    
    var gender: [Int] {
        print(movie.genreIDS)
        return movie.genreIDS
    }
    
    var description: String {
        return movie.overview
    }
    
    
    
    init(movie: Movie) {
        self.movie = movie
    }
}
