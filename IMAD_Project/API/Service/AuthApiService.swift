//
//  AuthApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Alamofire
import Combine

enum AuthApiService{
    static var intercept = BaseIntercept()
    
    static func login(id:String,password:String) -> AnyPublisher<UserResponse,AFError>{
        print("로그인 api 호출")
        return ApiClient.shared.session
            .request(AuthRouter.login(id: id, password: password))
//            .response{ response in
//                if let header = response.response?.headers{
////                    for i in header{
////                        i.name ==
////                    }
//                }
//            }
            .publishDecodable(type: UserResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func register(id:String,email:String,password:String) -> AnyPublisher<RegisterResponse,AFError>{
        print("회원가입 api 호출")
        return ApiClient.shared.session
            .request(AuthRouter.login(id: id, password: password))
            .publishDecodable(type: RegisterResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func kakaoAuth(code:String,status:Int) -> AnyPublisher<KakaoAuth,AFError>{
        print("카카오 로그인 요청")
        return ApiClient.shared.session
            .request(AuthRouter.kakao(code: code, statua: status))
            .publishDecodable(type: KakaoAuth.self)
            .value()
            .eraseToAnyPublisher()
    }
}
