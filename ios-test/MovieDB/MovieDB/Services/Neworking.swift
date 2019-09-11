//
//  Neworking.swift
//  MovieDB
//
//  Created by Eddwin Paz on 9/6/19.
//  Copyright © 2019 acme dot inc. All rights reserved.
//

import Foundation

/// Error Descriptions for network requests
///
/// - unknown: unknown request
/// - failedRequest: request failed possible 400++
/// - invalidResponse: Request containst invalid parameters or method
/// - invalidCredentials: Request returned a 403 HTTP Status Code
/// - noErrors: Request returned 200 HTTP Status Code
/// - invalidJson: Request returned a invalid JSON (impossible to encode)
enum DataManagerError: Error {
    case unknown
    case failedRequest
    case invalidResponse
    case invalidCredentials
    case noErrors
    case invalidJson
    case emptyResponse
}

extension DataManagerError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown:
            return NSLocalizedString("Error Desconocido", comment: "Error")
        case .failedRequest:
            return NSLocalizedString("Solicititud fallo", comment: "Error")
        case .invalidResponse:
            return NSLocalizedString("Respuesta del servidor invalida", comment: "Error")
        case .invalidCredentials:
            return NSLocalizedString("Credenciales Invalidas, Inicie sesión nuevamente", comment: "Error")
        case .noErrors:
            return NSLocalizedString("Sin Errores", comment: "Error")
        case .invalidJson:
            return NSLocalizedString("Json posee errores", comment: "Error")
        case .emptyResponse:
            return NSLocalizedString("No hay resultados", comment: "Error")
        }
    }
}

class Network: NSObject {
    var apiToken: String = "16e1fc6c05c67098e7f7f5c8b4ff6528"
    var endPont: String = "https://api.themoviedb.org"
    static let shared = Network()

    /// Generic Network Data that POST a form to a URL given.
    ///
    /// - Parameters:
    ///   - url: URL()
    ///   - payload: url: Url, payload: Struct form
    ///   - completion: T, DataManagerError

    func fetchData<T: Decodable>(url: URL, completion: @escaping (T?, DataManagerError) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in

            if error != nil {
                print(error.debugDescription)
                completion(nil, .failedRequest)
                return
            }

//            print(String(data: data!, encoding: .utf8) as Any)

            guard let response = response as? HTTPURLResponse, (200 ... 299).contains(response.statusCode) else {
                completion(nil, .invalidCredentials)
                return
            }

            if let mimeType = response.mimeType, mimeType == "application/json", let data = data {
                do {
                    if data.isEmpty {
                        completion(nil, .emptyResponse)
                        return
                    }

                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(T.self, from: data)

                    completion(response, .noErrors)

                } catch {
                    completion(nil, .invalidJson)
                }
            }
        }).resume()
    }
}
