//
//  UserApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/16.
//

import Foundation
import Alamofire
import Combine

enum UserApiService{
    
    
    static var intercept = BaseIntercept()
    
    static func user(userId:Int) -> AnyPublisher<GetUserInfo,AFError>{
        print("유저정보 api 호출")
        return ApiClient.shared.session
            .request(UserRouter.user(userId: userId),interceptor: intercept)
            .publishDecodable(type: GetUserInfo.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func patchUser(gender:String?,ageRange:Int?,image:Int,nickname:String,genre:String?,userId:Int) -> AnyPublisher<GetUserInfo,AFError>{
        print("유저정보변경 api 호출")
        return ApiClient.shared.session
            .request(UserRouter.patchUser(gender: gender, ageRange: ageRange, image: image, nickname: nickname, genre: genre,userId: userId),interceptor: intercept)
            .publishDecodable(type: GetUserInfo.self)
            .value()
            .eraseToAnyPublisher()
    }


}
