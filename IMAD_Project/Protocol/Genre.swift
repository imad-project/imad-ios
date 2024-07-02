//
//  Genre.swift
//  IMAD_Project
//
//  Created by 유영웅 on 3/13/24.
//

import Foundation


enum GenreType{
    case tv,movie
}

protocol Genre{
    var genreType:GenreType { get }
    func selectName() -> String
    func selectImage() -> String
    func selectCode() -> Int
}

class TVGenre:Genre{
    var genreType: GenreType = .tv
    var tvGenre:TVGenreFilter
    required init(tvGenre:TVGenreFilter) {
        self.tvGenre = tvGenre
    }
    func selectName() -> String {
        return tvGenre.name
    }
    func selectImage() -> String {
        return tvGenre.image
    }
    func selectCode() -> Int {
        return tvGenre.rawValue
    }
}
class MovieGenre:Genre{
    var genreType: GenreType = .movie
    var movieGenre:MovieGenreFilter
    required init(movieGenre:MovieGenreFilter) {
        self.movieGenre = movieGenre
    }
    func selectName() -> String {
        return movieGenre.name
    }
    func selectImage() -> String {
        return movieGenre.image
    }
    func selectCode() -> Int {
        return movieGenre.rawValue
    }
}
