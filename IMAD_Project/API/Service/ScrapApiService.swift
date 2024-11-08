//
//  ScrapApitService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/22.
//

import Foundation
import Combine
import Alamofire

class ScrapApiService{
    
    static let interceptor = BaseIntercept()
    
    static func readScrap(page:Int)->AnyPublisher<NetworkResponse<NetworkListResponse<ScrapResponse>>,AFError>{
        print("스크랩 조회 api 호출")
        return ApiClient.shared.session
            .request(ScrapRouter.read(page: page),interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<NetworkListResponse<ScrapResponse>>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func writeScrap(postingId:Int)->AnyPublisher<NoDataResponse,AFError>{
        print("스크랩 등록 api 호출")
        return ApiClient.shared.session
            .request(ScrapRouter.write(postingId: postingId),interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NoDataResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func deleteScrap(scrapId:Int)->AnyPublisher<NoDataResponse,AFError>{
        print("스크랩 삭제 api 호출")
        return ApiClient.shared.session
            .request(ScrapRouter.delete(scrapId:scrapId),interceptor: interceptor)
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
