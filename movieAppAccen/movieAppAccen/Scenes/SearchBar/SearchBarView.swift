//
//  SearchBarView.swift
//  movieAppAccen
//
//  Created by Orlando Velasco on 21-10-23.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String
    
    var body: some View {
        ZStack {
            if searchText.isEmpty {
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            }
            TextField("", text: $searchText)
                .padding(12)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }
}
