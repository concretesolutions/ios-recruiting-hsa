//
//  MovieViewToModel.swift
//  ios-recruiting-hsa
//
//  Created on 10-08-19.
//

class MovieViewToModel: Mapper<MovieView, MovieModel> {
    override func reverseMap(value: MovieModel) -> MovieView {
        return MovieView(id: value.id,
                         title: value.title,
                         posterPath: value.posterPath != nil ? MovieURL.imageUrl + value.posterPath! : ""
        )
    }
}
