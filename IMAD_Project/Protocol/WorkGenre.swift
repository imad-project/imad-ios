//
//  WorkGenre.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/26/24.
//

import Foundation

enum WorkGenreType{
    case tv,movie
}

protocol WorkGenre{
    var genreType:WorkGenreType { get }
    func id() -> Int
    func posterPath() -> String?
    func backdropPath() -> String?
}

class TVWorkGenre:WorkGenre{
    var genreType: WorkGenreType = .tv
    var tvGenre:RecommendTVResponse
    required init(tvGenre:RecommendTVResponse) {
        self.tvGenre = tvGenre
    }
    func id() -> Int {
        return tvGenre.id
    }
    func name()->String{
        return tvGenre.name
    }
    func posterPath() -> String? {
        return tvGenre.posterPath
    }
    func backdropPath() -> String? {
        return tvGenre.backdropPath
    }
}
class MovieWorkGenre:WorkGenre{
    var genreType: WorkGenreType = .movie
    var movieGenre:RecommendMovieResponse
    required init(movieGenre:RecommendMovieResponse) {
        self.movieGenre = movieGenre
    }
    func id() -> Int {
        return movieGenre.id
    }
    func title() -> String{
        return movieGenre.title
    }
    func posterPath() -> String? {
        return movieGenre.posterPath
    }
    func backdropPath() -> String? {
        return movieGenre.backdropPath
    }
}
