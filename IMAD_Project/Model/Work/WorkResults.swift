//
//  workResults.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/09.
//

import Foundation

struct WorkResults:Codable{
    
    var id:Int
    var title:String?
    var originalTitle:String?
    var releaseDate:String?
    var name:String?
    var originalName:String?
    var firstAirDate:String?
    var originCountry:[String]?
    var originalLanguage:String?
    var adult:Bool
    var backdropPath:String?
    var overview:String?
    var posterPath:String?
    var mediaType:String
    var genreIds:[Int]?
    var video:Bool
    
    enum CodingKeys:String,CodingKey{
        case id
        case title
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case name
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case adult
        case backdropPath = "backdrop_path"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIds = "genre_ids"
        case video
    }
}
