//
//  MovieDetailViewToModel.swift
//  ios-recruiting-hsa
//
//  Created on 11-08-19.
//

class MovieDetailViewToModel: Mapper<MovieDetailView, MovieDetailModel> {
    override func reverseMap(value: MovieDetailModel) -> MovieDetailView {
        var releaseDate: String = ""
        if let date = value.releaseDate {
            releaseDate = FormatHelper.stringDate(from: date, dateFormatType: .yyyy)
        }
        return MovieDetailView(id: value.id,
                               title: value.title,
                               overview: (value.overview != nil && !value.overview!.isEmpty) ? value.overview! : DetailConstants.Messages.emptyOverview,
                               posterPath: value.posterPath != nil ? MovieURL.imageUrl + value.posterPath! : "",
                               genres: value.genres.count > 0 ? value.genres.map({ $0.name }) : [DetailConstants.Messages.emptyGenres],
                               releaseDate: releaseDate
        )
    }
}
