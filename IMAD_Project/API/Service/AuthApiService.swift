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
    
    
    static func login(email:String,password:String) -> AnyPublisher<UserInfoResponse,AFError>{
        print("로그인 api 호출")
        return ApiClient.shared.session
            .request(AuthRouter.login(email: email, password: password))
            .response{ response in
                if let accessToken = response.response?.allHeaderFields["Authorization"] as? String,let refreshToken = response.response?.allHeaderFields["Authorization-refresh"] as? String{
                    UserDefaultManager.shared.setToken(accessToken: accessToken, refreshToken: refreshToken)
                }
            }
            .publishDecodable(type: UserInfoResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func register(email:String,nickname:String,password:String,authProvider:String) -> AnyPublisher<RegisterResponse,AFError>{
        
        print("회원가입 api 호출")
        
        return ApiClient.shared.session
            .request(AuthRouter.register(email: email, nickname: nickname, password: password,authProvider:authProvider))
           // .validate(statusCode: 200..<300)
//            .response{ response in
////                if let accessToken = response.response?.allHeaderFields["Authorization"] as? String,let refreshToken = response.response?.allHeaderFields["Authorization-refresh"] as? String{
////                    UserDefaultManager.shared.setToken(accessToken: accessToken, refreshToken: refreshToken)
////
////                }
//                switch response.result {
//                case .success:
//                    if let accessToken = response.response?.allHeaderFields["Authorization"] as? String,
//                       let refreshToken = response.response?.allHeaderFields["Authorization-refresh"] as? String {
//                        UserDefaultManager.shared.setToken(accessToken: accessToken, refreshToken: refreshToken)
//                    }
//                case .failure(let error):
//                    if let data = response.data,
//                       let errorMessage = String(data: data, encoding: .utf8) {
//                        print("Error1: \(errorMessage)")
//                    } else {
//                        print("Error2: \(error.localizedDescription)")
//                    }
//                }
//            }
            .publishDecodable(type: RegisterResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func oauth(registrationId:String) -> AnyPublisher<UserInfoResponse,AFError>{
        print("카카오 로그인 요청")
        return ApiClient.shared.session
            .request(AuthRouter.oauth(registrationId: registrationId))
            .response{ response in
                if let accessToken = response.response?.allHeaderFields["Authorization"] as? String,let refreshToken = response.response?.allHeaderFields["Authorization-refresh"] as? String{
                    UserDefaultManager.shared.setToken(accessToken: accessToken, refreshToken: refreshToken)
                }
            }
            .publishDecodable(type: UserInfoResponse.self)
            .value()
            .eraseToAnyPublisher()
            
    }
}

