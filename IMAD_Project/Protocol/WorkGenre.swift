//
//  WorkGenre.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/26/24.
//

import Foundation

enum WorkGenreType:String{
    case tv,movie
}

protocol WorkGenre{
    var genreType:WorkGenreType { get }
    var id:Int { get }
    func name()->String?
    func title()->String?
    func genreId() -> [Int]?
    func posterPath() -> String?
    func backdropPath() -> String?
}

class TVWorkGenre:WorkGenre{
    
    
    
    var genreType: WorkGenreType = .tv
    var tvGenre:RecommendTVResponse
    required init(tvGenre:RecommendTVResponse) {
        self.tvGenre = tvGenre
    }
    var id: Int{
        return tvGenre.id
    }
    func name()->String?{
        return tvGenre.name
    }
    func title() -> String?{
        return nil
    }
    func genreId() -> [Int]? {
        return tvGenre.genreIds
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
    var id: Int{
        return movieGenre.id
    }
    func name()->String?{
        return nil
    }
    func title() -> String?{
        return movieGenre.title
    }
    func genreId() -> [Int]? {
        return movieGenre.genreIds
    }
    func posterPath() -> String? {
        return movieGenre.posterPath
    }
    func backdropPath() -> String? {
        return movieGenre.backdropPath
    }
}
