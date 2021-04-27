protocol PopularMoviesRepository: class {
    func list(in page: String, completionHandler: @escaping (Movies?, ErrorModel?) -> Void)
}
