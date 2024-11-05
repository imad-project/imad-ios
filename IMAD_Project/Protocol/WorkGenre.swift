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
    var genreType:WorkGenreType{ get }
    var id:Int{ get }
    var name:String?{ get }
    var title:String?{ get }
    var genreId:[Int]?{ get }
    var posterPath:String?{ get }
    var backdropPath:String?{ get }
}



