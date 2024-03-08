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
    
    static let interseptor = BaseIntercept()
    
    static func weekRanking(page:Int,type:String) -> AnyPublisher<Ranking,AFError>{
        print("주간랭킹 api 호출")
        return ApiClient.shared.session
            .request(RankingRouter.week(page:page,type:type),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:Ranking.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func monthRanking(page:Int,type:String) -> AnyPublisher<Ranking,AFError>{
        print("월간랭킹 api 호출")
        return ApiClient.shared.session
            .request(RankingRouter.month(page:page,type:type),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:Ranking.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func allRanking(page:Int,type:String) -> AnyPublisher<Ranking,AFError>{
        print("전체랭킹 api 호출")
        return ApiClient.shared.session
            .request(RankingRouter.all(page:page,type:type),interceptor: interseptor)
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
            .request(RankingRouter.popularReivew)
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
            .request(RankingRouter.popularPosting)
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
