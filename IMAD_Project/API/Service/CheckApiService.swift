//
//  UserApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/16.
//

import Foundation
import Alamofire
import Combine

enum CheckApiService{
    
    static var intercept = BaseIntercept()
    
    static func checkEmail(email:String) -> AnyPublisher<NetworkResponse<ValidationResponse>,AFError>{
        print("email중복검사 api 호출")
        return ApiClient.shared.session
            .request(CheckRouter.checkEmail(email: email))
            .publishDecodable(type:NetworkResponse<ValidationResponse>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func checkNickname(nickname:String) -> AnyPublisher<NetworkResponse<ValidationResponse>,AFError>{
        print("닉네임 중복검사 api 호출")
        return ApiClient.shared.session
            .request(CheckRouter.checkNickname(nickname: nickname))
            .publishDecodable(type:NetworkResponse<ValidationResponse>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }

}
