//
//  MovieWorkGenre.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/28/24.
//

import Foundation

class MovieWorkGenre:WorkGenre{
    var genreType: WorkGenreType = .movie
    var movieGenre:RecommendMovieResponse
    required init(movieGenre:RecommendMovieResponse) {
        self.movieGenre = movieGenre
    }
    var id: Int{movieGenre.id}
    var name:String?
    var title:String?{ movieGenre.title }
    var genreId:[Int]?{ movieGenre.genreIds }
    var posterPath:String?{ movieGenre.posterPath }
    var backdropPath:String?{ movieGenre.backdropPath }
}
