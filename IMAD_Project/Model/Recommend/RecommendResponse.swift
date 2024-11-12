//
//  RecommendLists.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation

struct RecommendResponse: Codable,Hashable {
    
    let id:Int
    var name:String?
    var title:String?
    let posterPath:String?
    let backdropPath:String?
    let genreIds:[Int]?
    
    var displayTitle: String {
            return name ?? title ?? "" 
        }
    var genreType:GenreType{
        return name != nil ? .tv : .movie
    }

    enum CodingKeys: String, CodingKey {
        case id, name,title
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
    }
}
