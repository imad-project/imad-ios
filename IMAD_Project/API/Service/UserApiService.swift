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
    
    static func user() -> AnyPublisher<UserInfoResponse,AFError>{
        print("로그인 api 호출")
        return ApiClient.shared.session
            .request(UserRouter.user,interceptor: intercept)
            .publishDecodable(type: UserInfoResponse.self)
            .value()
            .eraseToAnyPublisher()
    }


}
