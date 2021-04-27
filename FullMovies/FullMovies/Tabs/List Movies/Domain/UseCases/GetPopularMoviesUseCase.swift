struct GetPopularMoviesUseCase {
    private let popularMoviesRepository: PopularMoviesRepository
    
    init(popularMoviesRepository: PopularMoviesRepository) {
        self.popularMoviesRepository = popularMoviesRepository
    }
    
    func execute(with key: String, completionHandler: @escaping (Movies?, ErrorModel?) -> Void){
        popularMoviesRepository.list(in: key){ response, error in
            completionHandler(response, error)
        }
    }
}
