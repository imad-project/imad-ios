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
    
    static func user() -> AnyPublisher<UserInfo,AFError>{
        print("유저정보 api 호출")
        return ApiClient.shared.session
            .request(UserRouter.user,interceptor: intercept)
            .validate(statusCode: 200..<300)
//            .response{ response in
//                switch response.result{
//                case .success:
//                    print("요청성공")
//                case .failure(let error):
//                    print("요청실패 : \(error.localizedDescription)")
//                }
//            }
            .publishDecodable(type: UserInfo.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func patchUser(gender:String?,ageRange:Int?,image:Int,nickname:String,tvGenre:[Int]?,movieGenre:[Int]?) -> AnyPublisher<UserInfo,AFError>{
        print("유저정보변경 api 호출")
        return ApiClient.shared.session
            .request(UserRouter.patchUser(gender: gender, ageRange: ageRange, image: image, nickname: nickname, tvGenre: tvGenre,movieGenre: movieGenre),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: UserInfo.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func passwordChange(old:String,new:String)-> AnyPublisher<NoDataResponse,AFError>{
        print("비밀번호변경 api 호출")
        return ApiClient.shared.session
            .request(UserRouter.passwordChange(old: old, new: new),interceptor: intercept)
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
