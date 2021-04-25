protocol PopularMoviesRepository: class {
    func list(with key: String, completionHandler: @escaping (Movies?, ErrorModel?) -> Void)
}
