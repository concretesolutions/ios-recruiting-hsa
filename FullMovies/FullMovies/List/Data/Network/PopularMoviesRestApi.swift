protocol PopularMoviesRestApi {
    func list(in page: String, completionHandler: @escaping (Movies?, NetworkError?) -> Void)
}
