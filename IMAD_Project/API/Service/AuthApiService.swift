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
    
    static let intercept = BaseIntercept()
    
    static func login(email:String,password:String) -> AnyPublisher<UserInfo,AFError>{
        print("로그인 api 호출")
        return ApiClient.shared.session
            .request(AuthRouter.login(email: email, password: password))
            .response{UserDefaultManager.shared.checkToken(response: $0.response)}
            .publishDecodable(type: UserInfo.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지 : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func register(email:String,password:String,authProvider:String) -> AnyPublisher<NoDataResponse,AFError>{
        print("회원가입 api 호출")
        return ApiClient.shared.session
            .request(AuthRouter.register(email: email, password: password,authProvider:authProvider))
            .publishDecodable(type: NoDataResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지 : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func delete(authProvier:String) -> AnyPublisher<NoDataResponse,AFError>{
        print("회원탈퇴 api 호출")
        return ApiClient.shared.session
            .request(authProvier != "IMAD" ? AuthRouter.oauthDelete(authProvider:authProvier) : AuthRouter.delete,interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NoDataResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}

