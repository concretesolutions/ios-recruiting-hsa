struct GetPopularMoviesUseCase {
    private let popularMoviesRepository: PopularMoviesRepository
    
    init(popularMoviesRepository: PopularMoviesRepository) {
        self.popularMoviesRepository = popularMoviesRepository
    }
    
    func execute(with key: String, completionHandler: @escaping (Movies?, ErrorModel?) -> Void){
        popularMoviesRepository.list(with: key){ response, error in
            completionHandler(response, error)
        }
    }
}
