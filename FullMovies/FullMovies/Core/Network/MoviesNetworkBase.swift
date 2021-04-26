import Foundation

class FullMoviesNetworkBase {
    
    public var codableHelper: CodableHelper
    public var network: FullMoviesNetwork
    public var urlHelper: UrlHelper
    
    public required init(network: FullMoviesNetwork) {
        self.network = network
        codableHelper = CodableHelper()
        urlHelper = UrlHelper()
    }
}
