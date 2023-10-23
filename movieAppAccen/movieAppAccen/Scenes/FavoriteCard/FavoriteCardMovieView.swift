//
//  FavoriteCardMovieView.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 22-10-23.
//

import SwiftUI

struct FavoriteCardMovieView: View {
    let movie: FavoriteMovie

    var body: some View {
        HStack(spacing: 10) {
            
            if let posterPath = movie.posterPath {
                ImageView(url: posterPath).frame(width: 80, height: 120)
            } else {
                Image("defaultImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 120)
                    .clipped()
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(movie.title ?? "")
                    .fontWeight(.bold)
                
                Text(dateFormatter.string(from: movie.releaseDate ?? Date()).split(separator: "-")[2])
                
                Text(movie.overview ?? "")
                    .lineLimit(2)
            }
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
