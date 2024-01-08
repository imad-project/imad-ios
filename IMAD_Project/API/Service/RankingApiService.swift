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
    
    static func weekRanking() -> AnyPublisher<Ranking,AFError>{
        print("주간랭킹 api 호출")
        return ApiClient.shared.session
            .request(RankingRouter.week,interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:Ranking.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func monthRanking() -> AnyPublisher<Ranking,AFError>{
        print("월간랭킹 api 호출")
        return ApiClient.shared.session
            .request(RankingRouter.month,interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:Ranking.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func allRanking() -> AnyPublisher<Ranking,AFError>{
        print("전체랭킹 api 호출")
        return ApiClient.shared.session
            .request(RankingRouter.all,interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:Ranking.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
