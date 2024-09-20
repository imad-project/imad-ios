//
//  RankingApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 1/8/24.
//

import Foundation
import Alamofire
import Combine

class RankingApiService{
    
    static let interseptor = GuestInterceptor()
    
    static func ranking(endPoint:RankingFilter,page:Int,mediaType:String) -> AnyPublisher<Ranking,AFError>{
        print("\(endPoint.name)랭킹 api 호출")
        return ApiClient.shared.session
            .request(RankingRouter.ranking(endPoint: endPoint.endPoint, page: page, mediaType: mediaType),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:Ranking.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func popularReview() -> AnyPublisher<PopluarReview,AFError>{
     print("오늘의 리뷰 api 호출")
        return ApiClient.shared.session
            .request(RankingRouter.popularReivew,interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: PopluarReview.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func popluarPosting() -> AnyPublisher<PopularPosting,AFError>{
     print("오늘의 게시물 api 호출")
        return ApiClient.shared.session
            .request(RankingRouter.popularPosting,interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: PopularPosting.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
}
