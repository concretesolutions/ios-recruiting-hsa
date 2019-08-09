//
//  MovieDetailModelToEntity.swift
//  ios-recruiting-hsa
//
//  Created on 08-08-19.
//

class MovieDetailModelToEntity: Mapper<MovieDetailModel, MovieDetailEntity> {
    private let collectionModelToEntity: Mapper<CollectionModel, CollectionEntity>
    private let genreModelToEntity: Mapper<GenreModel, GenreEntity>
    private let productionCompanyModelToEntity: Mapper<ProductionCompanyModel, ProductionCompanyEntity>
    private let productionCountryModelToEntity: Mapper<ProductionCountryModel, ProductionCountryEntity>
    private let spokenLanguageModelToEntity: Mapper<SpokenLanguageModel, SpokenLanguageEntity>
    
    init(collectionModelToEntity: Mapper<CollectionModel, CollectionEntity>,
         genreModelToEntity: Mapper<GenreModel, GenreEntity>,
         productionCompanyModelToEntity: Mapper<ProductionCompanyModel, ProductionCompanyEntity>,
         productionCountryModelToEntity: Mapper<ProductionCountryModel, ProductionCountryEntity>,
         spokenLanguageModelToEntity: Mapper<SpokenLanguageModel, SpokenLanguageEntity>
    ) {
        self.collectionModelToEntity = collectionModelToEntity
        self.genreModelToEntity = genreModelToEntity
        self.productionCompanyModelToEntity = productionCompanyModelToEntity
        self.productionCountryModelToEntity = productionCountryModelToEntity
        self.spokenLanguageModelToEntity = spokenLanguageModelToEntity
    }
    
    override func reverseMap(value : MovieDetailEntity) -> MovieDetailModel {
        var belongsToCollection: CollectionModel? = nil
        if let collection = value.belongsToCollection {
            belongsToCollection = collectionModelToEntity.reverseMap(value: collection)
        }
        
        return MovieDetailModel(isAdult: value.isAdult,
                                backdropPath: value.backdropPath,
                                belongsToCollection: belongsToCollection,
                                budget: value.budget,
                                genres: genreModelToEntity.reverseMap(values: value.genres),
                                homepage: value.homepage,
                                id: value.id,
                                imdbId: value.imdbId,
                                originalLanguage: value.originalLanguage,
                                originalTitle: value.originalTitle,
                                overview: value.overview,
                                popularity: value.popularity,
                                posterPath: value.posterPath,
                                productionCompanies: productionCompanyModelToEntity.reverseMap(values: value.productionCompanies),
                                productionCountries: productionCountryModelToEntity.reverseMap(values: value.productionCountries),
                                releaseDate: FormatHelper.date(from: value.releaseDate),
                                revenue: value.revenue,
                                runtime: value.runtime,
                                spokenLanguages: spokenLanguageModelToEntity.reverseMap(values: value.spokenLanguages),
                                status: value.status,
                                tagline: value.tagline,
                                title: value.title,
                                isVideo: value.isVideo,
                                voteAverage: value.voteAverage,
                                voteCount: value.voteCount)
    }
}
