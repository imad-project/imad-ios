//
//  RecommendApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation
import Alamofire
import Combine

class RecommendApiService{
    static let interseptor = GuestInterceptor()
    
    static func all() -> AnyPublisher<AllRecommend,AFError>{
        print("전체 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.all,interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:AllRecommend.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.self)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func genre(page:Int) -> AnyPublisher<GenreRecommend,AFError>{
        print("장르 기반 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.genre(page: page),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:GenreRecommend.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.self)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func activity(page:Int) -> AnyPublisher<ActivityRecommend,AFError>{
        print("활동 기반 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.genre(page: page),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:ActivityRecommend.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.self)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func imad(page:Int) -> AnyPublisher<ImadRecommend,AFError>{
        print("Imad 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.imad(page: page),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:ImadRecommend.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.self)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func trend(page:Int) -> AnyPublisher<TrendRecommend,AFError>{
        print("대세 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.trend(page: page),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:TrendRecommend.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.self)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
