import Alamofire
import Foundation

public final class FullMoviesNetwork {
    
    func execute(
        url:String,
        method: HTTPMethod = .get,r
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        onCompletion: @escaping (AFDataResponse<Data>) -> Void) {
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding
        ).responseData { response in
            if let status = response.response?.statusCode, status ==  NetworkConstants.StatusCode.unauthorized.rawValue {
                return
            } else {
                onCompletion(response)
            }
        }
    }
}
