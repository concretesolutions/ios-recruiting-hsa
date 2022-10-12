//
//  AsyncMovieImageView.swift
//  Concrete Challenge
//
//  Created by Jonathan Pacheco on 11/10/22.
//

import SwiftUI

struct AsyncMovieImageView: View {
    
    let path: String?
    
    var body: some View {
        if let path {
            AsyncImage(
                url: URL(string: "https://image.tmdb.org/t/p/w500\(path)"),
                content: {
                    $0.resizable()
                        .clipped()
                },
                placeholder: {
                    Image(systemName: "photo")
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
            )
        } else {
            Image(systemName: "photo")
                .resizable()
                .imageScale(.large)
        }
    }
}

struct AsyncMovieImageView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView {
            AsyncMovieImageView(path: "/jsoz1HlxczSuTx0mDl2h0lxy36l.jpg")
        }
    }
}
