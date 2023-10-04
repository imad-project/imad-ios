//
//  BookMark.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/04.
//

import Foundation

struct Bookmark:Codable{
    let status:Int
    var data:BookmarkResponse?
    let message:String
}
