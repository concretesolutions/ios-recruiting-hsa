//
//  ListMovieResponse.swift
//  movie-app-hsa
//
//  Created by training on 03-07-22.
//

import Foundation

// MARK: ListMovieResponse
struct ListMovieResponse: Codable {

    let genres: [GenreResonse]
    let statusCode: Int?
    let statusMessage: String?
    let success: Bool?

    enum CodingKeys: String, CodingKey {
        case genres
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}

// MARK: - Genre
struct GenreResonse: Codable {
    let id: Int
    let name: String
}
