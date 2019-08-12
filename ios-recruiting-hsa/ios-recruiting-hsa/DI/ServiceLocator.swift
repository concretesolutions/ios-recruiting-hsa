//
//  ServiceLocator.swift
//  ios-recruiting-hsa
//
//  Created on 8/8/19.
//

class ServiceLocator {
    private let codableHelper = CodableHelper()
    
    // Data
    
    private var movieRestApi: MovieRestApi {
        return MovieRestApiImpl(codableHelper: codableHelper)
    }
    
    private var movieLocalData: MovieLocalData {
        return MovieLocalDataimpl()
    }
    
    private var favoriteMovieModelToEntity: Mapper<FavoriteMovieModel, FavoriteMovieEntity> {
        return FavoriteMovieModelToEntity()
    }
    
    private var movieModelToEntity: Mapper<MovieModel, MovieEntity> {
        return MovieModelToEntity()
    }
    
    private var movieResponseModelToEntity: Mapper<MovieResponseModel, MovieResponseEntity> {
        return MovieResponseModelToEntity(movieModelToEntity: movieModelToEntity)
    }
    
    private var partModelToEntity: Mapper<PartModel, PartEntity> {
        return PartModelToEntity()
    }
    
    private var collectionModelToEntity: Mapper<CollectionModel, CollectionEntity> {
        return CollectionModelToEntity(partModelToEntity: partModelToEntity)
    }
    
    private var genreModelToEntity: Mapper<GenreModel, GenreEntity> {
        return GenreModelToEntity()
    }
    
    private var productionCompanyModelToEntity: Mapper<ProductionCompanyModel, ProductionCompanyEntity> {
        return ProductionCompanyModelToEntity()
    }
    
    private var productionCountryModelToEntity: Mapper<ProductionCountryModel, ProductionCountryEntity> {
        return ProductionCountryModelToEntity()
    }
    
    private var spokenLanguageModelToEntity: Mapper<SpokenLanguageModel, SpokenLanguageEntity> {
        return SpokenLanguageModelToEntity()
    }
    
    private var movieDetailModelToEntity: Mapper<MovieDetailModel, MovieDetailEntity> {
        return MovieDetailModelToEntity(collectionModelToEntity: collectionModelToEntity,
                                        genreModelToEntity: genreModelToEntity,
                                        productionCompanyModelToEntity: productionCompanyModelToEntity,
                                        productionCountryModelToEntity: productionCountryModelToEntity,
                                        spokenLanguageModelToEntity: spokenLanguageModelToEntity)
    }
    
    private var errorModelToEntity: Mapper<ErrorModel, ErrorEntity> {
        return ErrorModelToEntity()
    }
    
    private var movieDataRepository: MovieRepository {
        return MovieRepositoryImpl(movieRestApi: movieRestApi,
                                   movieLocalData: movieLocalData,
                                   favoriteMovieModelToEntity: favoriteMovieModelToEntity,
                                   movieResponseModelToEntity: movieResponseModelToEntity,
                                   movieDetailModelToEntity: movieDetailModelToEntity,
                                   errorModelToEntity: errorModelToEntity
        )
    }
    
    // Domain
    
    private var movieUseCase: MovieUseCase {
        return MovieUseCase(movieRepository: movieDataRepository)
    }
    
    // View
    
    private var movieDetailViewToFavoriteMovieModel: Mapper<MovieDetailView, FavoriteMovieModel> {
        return MovieDetailViewToFavoriteMovieModel()
    }
    
    private var favoriteMovieViewToModel: Mapper<FavoriteMovieView, FavoriteMovieModel> {
        return FavoriteMovieViewToModel()
    }
    
    private var movieViewToModel: Mapper<MovieView, MovieModel> {
        return MovieViewToModel()
    }
    
    private var movieDetailViewToModel: Mapper<MovieDetailView, MovieDetailModel> {
        return MovieDetailViewToModel()
    }
    
    private var errorViewToModel: Mapper<ErrorView, ErrorModel> {
        return ErrorViewToModel()
    }
    
    // Grid
    var gridPresenter: GridPresenter {
        return GridPresenterImpl(movieUseCase: movieUseCase,
                                 movieViewToModel: movieViewToModel,
                                 errorViewToModel: errorViewToModel
        )
    }
    
    // Detail
    var detailPresenter: DetailPresenter {
        return DetailPresenterImpl(movieUseCase: movieUseCase,
                                   movieDetailViewToFavoriteMovieModel: movieDetailViewToFavoriteMovieModel,
                                   movieDetailViewToModel: movieDetailViewToModel,
                                   errorViewToModel: errorViewToModel
        )
    }
    
    // Favorites
    var favoritePresenter: FavoritePresenter {
        return FavoritePresenterImpl(movieUseCase: movieUseCase,
                                     favoriteMovieViewToModel: favoriteMovieViewToModel,
                                     errorViewToModel: errorViewToModel
        )
    }
}
