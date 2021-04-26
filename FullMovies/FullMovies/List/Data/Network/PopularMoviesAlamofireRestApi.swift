import Foundation

class PopularMoviesAlamofireRestApi : FullMoviesNetworkBase, PopularMoviesRestApi {
    func list(in page: String, completionHandler: @escaping (Movies?, NetworkError?) -> Void) {
        let url = String(format: urlHelper.url(for: .popularMovies), NetworkConstants.ApiKey.value, page)
        network.execute(url: url) { response in
            if let data = response.data, let model: Movies = try? self.codableHelper.decodeNetworkObject(object: data) {
                completionHandler(model, nil)
            } else {
                completionHandler(nil, self.codableHelper.generateErrorFor(object: response.data))
            }
        }
    }
}
