class PopularMoviesApiRepository: PopularMoviesRepository {
    private var popularMoviesRestApi : PopularMoviesRestApi
    private let errorMapper: Mapper<ErrorModel, NetworkError>
    
    init(popularMoviesRestApi : PopularMoviesRestApi, errorMapper: Mapper<ErrorModel, NetworkError>) {
        self.popularMoviesRestApi = popularMoviesRestApi
        self.errorMapper = errorMapper
    }
    
    func list(in page: String, completionHandler: @escaping (Movies?, ErrorModel?) -> Void) {
        popularMoviesRestApi.list(in: page) { moviesModel, error in
            if let error = error {
                completionHandler(nil, self.errorMapper.reverseMap(value: error))
            } else {
                completionHandler(moviesModel, nil)
            }
        }
    }
}
