import Foundation

class UrlHelper {
    func url(
        for endpoint: NetworkConstants.Endpoint,
        version: String = NetworkConstants.Version.v3
    ) -> String {
        return NetworkConstants.Endpoint.base.rawValue + version + endpoint.rawValue
    }
}
