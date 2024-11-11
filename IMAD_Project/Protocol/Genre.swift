////
////  Genre.swift
////  IMAD_Project
////
////  Created by 유영웅 on 3/13/24.
////
//
//import Foundation
//
//
enum GenreType:String{
    case tv,movie
}
protocol Genre{
    var genreType:GenreType{ get }
    var selectName:String{ get }
    var selectImage:String{ get }
    var selectCode:Int{ get }
}
class TVGenre:Genre{
    var genreType: GenreType = .tv
    var tvGenre:TVGenreFilter
    required init(tvGenre:TVGenreFilter) {
        self.tvGenre = tvGenre
    }
    var selectName:String {
        return tvGenre.name
    }
    var selectImage:String {
        return tvGenre.image
    }
    var selectCode:Int {
        return tvGenre.rawValue
    }
}
class MovieGenre:Genre{
    var genreType: GenreType = .movie
    var movieGenre:MovieGenreFilter
    required init(movieGenre:MovieGenreFilter) {
        self.movieGenre = movieGenre
    }
    var selectName:String {
        return movieGenre.name
    }
    var selectImage:String {
        return movieGenre.image
    }
    var selectCode:Int {
        return movieGenre.rawValue
    }
}
