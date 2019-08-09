//
//  MovieDetailToEntityTests.swift
//  ios-recruiting-hsaTests
//
//  Created on 08-08-19.
//

@testable import ios_recruiting_hsa
import XCTest

class MovieDetailModelToEntityTests: XCTestCase {
    var movieDetailModelToEntity: Mapper<MovieDetailModel, MovieDetailEntity>!
    
    override func setUp() {
        super.setUp()
        movieDetailModelToEntity = MovieDetailModelToEntity(
            collectionModelToEntity: CollectionModelToEntity(partModelToEntity: PartModelToEntity()),
            genreModelToEntity: GenreModelToEntity(),
            productionCompanyModelToEntity: ProductionCompanyModelToEntity(),
            productionCountryModelToEntity: ProductionCountryModelToEntity(),
            spokenLanguageModelToEntity: SpokenLanguageModelToEntity()
        )
    }
    
    override func tearDown() {
        movieDetailModelToEntity = nil
        super.tearDown()
    }

    func testReverseMap() {
        guard let entity = try? MovieDetailEntity.mocked(testCase: self) else {
            XCTFail("Failed to create entity")
            return
        }
        
        let model = movieDetailModelToEntity.reverseMap(value: entity)
        
        XCTAssertEqual(entity.isAdult, model.isAdult)
        XCTAssertEqual(entity.backdropPath, model.backdropPath)
        
        if let collection = entity.belongsToCollection, let modelCollection = model.belongsToCollection {
            XCTAssertEqual(collection.overview, modelCollection.overview)
            XCTAssertEqual(collection.backdropPath, modelCollection.backdropPath)
            XCTAssertEqual(collection.posterPath, modelCollection.posterPath)
            XCTAssertEqual(collection.id, modelCollection.id)
            
            if let parts = collection.parts, let modelParts = modelCollection.parts {
                for index in (0...parts.count - 1) {
                    XCTAssertEqual(parts[index].isAdult, modelParts[index].isAdult)
                    XCTAssertEqual(parts[index].backdropPath, modelParts[index].backdropPath)
                    XCTAssertEqual(parts[index].genreIds, modelParts[index].genreIds)
                    XCTAssertEqual(parts[index].id, modelParts[index].id)
                    XCTAssertEqual(parts[index].originalLanguage, modelParts[index].originalLanguage)
                    XCTAssertEqual(parts[index].originalTitle, modelParts[index].originalTitle)
                    XCTAssertEqual(parts[index].overview, modelParts[index].overview)
                    XCTAssertEqual(parts[index].releaseDate, FormatHelper.stringDate(from: modelParts[index].releaseDate!))
                    XCTAssertEqual(parts[index].posterPath, modelParts[index].posterPath)
                    XCTAssertEqual(parts[index].popularity, modelParts[index].popularity)
                    XCTAssertEqual(parts[index].title, modelParts[index].title)
                    XCTAssertEqual(parts[index].isVideo, modelParts[index].isVideo)
                    XCTAssertEqual(parts[index].voteAverage, modelParts[index].voteAverage)
                    XCTAssertEqual(parts[index].voteCount, modelParts[index].voteCount)
                }
            }
        }
        
        XCTAssertEqual(entity.budget, model.budget)
        
        for index in (0...entity.genres.count - 1) {
            XCTAssertEqual(entity.genres[index].id, model.genres[index].id)
            XCTAssertEqual(model.genres[index].name, model.genres[index].name)
        }
        
        XCTAssertEqual(entity.homepage, model.homepage)
        XCTAssertEqual(entity.id, model.id)
        XCTAssertEqual(entity.imdbId, model.imdbId)
        XCTAssertEqual(entity.originalLanguage, model.originalLanguage)
        XCTAssertEqual(entity.originalTitle, model.originalTitle)
        XCTAssertEqual(entity.overview, model.overview)
        XCTAssertEqual(entity.popularity, model.popularity)
        XCTAssertEqual(entity.posterPath, model.posterPath)
        
        for index in (0...entity.productionCompanies.count - 1) {
            XCTAssertEqual(entity.productionCompanies[index].id, model.productionCompanies[index].id)
            XCTAssertEqual(entity.productionCompanies[index].logoPath, model.productionCompanies[index].logoPath)
            XCTAssertEqual(entity.productionCompanies[index].name, model.productionCompanies[index].name)
            XCTAssertEqual(entity.productionCompanies[index].originCountry, model.productionCompanies[index].originCountry)
        }
        
        for index in (0...entity.productionCountries.count - 1) {
            XCTAssertEqual(entity.productionCountries[index].iso31661, model.productionCountries[index].iso31661)
            XCTAssertEqual(entity.productionCountries[index].name, model.productionCountries[index].name)
        }
        
        XCTAssertEqual(entity.releaseDate, FormatHelper.stringDate(from: model.releaseDate!))
        XCTAssertEqual(entity.revenue, model.revenue)
        XCTAssertEqual(entity.runtime, model.runtime)
        
        for index in (0...entity.spokenLanguages.count - 1) {
            XCTAssertEqual(entity.spokenLanguages[index].iso6391, model.spokenLanguages[index].iso6391)
            XCTAssertEqual(entity.spokenLanguages[index].name, model.spokenLanguages[index].name)
        }
        
        XCTAssertEqual(entity.status, model.status)
        XCTAssertEqual(entity.tagline, model.tagline)
        XCTAssertEqual(entity.title, model.title)
        XCTAssertEqual(entity.isVideo, model.isVideo)
        XCTAssertEqual(entity.voteAverage, model.voteAverage)
        XCTAssertEqual(entity.voteCount, model.voteCount)
    }
}
