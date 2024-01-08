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
        return ApiClient.shared.session
            .request(RankingRouter.week,interceptor: interseptor)
            .publishDecodable(type:Ranking.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func monthRanking() -> AnyPublisher<Ranking,AFError>{
        return ApiClient.shared.session
            .request(RankingRouter.month,interceptor: interseptor)
            .publishDecodable(type:Ranking.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func allRanking() -> AnyPublisher<Ranking,AFError>{
        return ApiClient.shared.session
            .request(RankingRouter.all,interceptor: interseptor)
            .publishDecodable(type:Ranking.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
