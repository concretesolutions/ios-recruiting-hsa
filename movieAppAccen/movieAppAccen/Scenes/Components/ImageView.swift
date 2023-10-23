//
//  ImageView.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 22-10-23.
//

import SwiftUI
import URLImage

struct ImageView: View {
    let url: String
    let baseURL = "https://image.tmdb.org/t/p/w500/"
    
    var body: some View {
        URLImage(URL(string: baseURL + url)!) {
            EmptyView()
        } inProgress: { progress in
            Text("Loading...")
        } failure: { error, retry in
            VStack {
                Text(error.localizedDescription)
                Button("Retry", action: retry)
            }
        } content: { image in
            image
                .resizable()
        }
    }
}
