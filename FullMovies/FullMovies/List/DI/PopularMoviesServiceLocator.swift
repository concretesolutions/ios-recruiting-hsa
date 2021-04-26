class PopularMoviesServiceLocator {
    
    private var popularMoviesRestApi: PopularMoviesRestApi {
        return PopularMoviesAlamofireRestApi(
            network: FullMoviesNetwork()
        )
    }
    
    private var popularMoviesRepository: PopularMoviesRepository {
        return PopularMoviesApiRepository(
            popularMoviesRestApi: popularMoviesRestApi,
            errorMapper: ErrorModelMapper()
        )
    }
    
    var getPopularMoviesUseCase:GetPopularMoviesUseCase {
        return GetPopularMoviesUseCase(
            popularMoviesRepository: popularMoviesRepository
        )
    }
}
