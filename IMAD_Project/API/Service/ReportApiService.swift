//
//  ReportApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/18/24.
//

import Foundation
import Alamofire
import Combine

class ReportApiService{
    
    static let interceptor = BaseIntercept()
    
    static func user(id:Int,type:String,description:String) -> AnyPublisher<NoDataResponse,AFError>{
        print("유저 신고 api 호출")
        return ApiClient.shared.session
            .request(ReportRouter.user(id: id, type: type, description: description),interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NoDataResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func review(id:Int,type:String,description:String) -> AnyPublisher<NoDataResponse,AFError>{
        print("리뷰 신고 api 호출")
        return ApiClient.shared.session
            .request(ReportRouter.review(id: id, type: type, description: description),interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NoDataResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func posting(id:Int,type:String,description:String) -> AnyPublisher<NoDataResponse,AFError>{
        print("게시글 신고 api 호출")
        return ApiClient.shared.session
            .request(ReportRouter.posting(id: id, type: type, description: description),interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NoDataResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func comment(id:Int,type:String,description:String) -> AnyPublisher<NoDataResponse,AFError>{
        print("댓글 신고 api 호출")
        return ApiClient.shared.session
            .request(ReportRouter.comment(id: id, type: type, description: description),interceptor: interceptor)
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
