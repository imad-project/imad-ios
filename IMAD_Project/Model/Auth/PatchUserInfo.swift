//
//  PatchUserInfo.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/08.
//

import Foundation

struct PatchUserInfo{
    var nickname:String
    var gender:String
    var age:Int
    var movieGenre:[Int]
    var tvGenre:[Int]
    var profileImageCode:Int
    
    init(user:UserResponse?) {
        self.nickname = user?.nickname ?? ""
        self.gender = user?.gender ?? ""
        self.age = user?.birthYear ?? 0
        self.movieGenre = user?.movieGenre ?? []
        self.tvGenre = user?.tvGenre ?? []
        self.profileImageCode = user?.profileImage ?? 1
    }
}
