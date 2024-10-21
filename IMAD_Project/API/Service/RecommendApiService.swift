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
    static let interseptor = BaseIntercept()
    
    static func all() -> AnyPublisher<AllRecommend,AFError>{
        print("전체 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.all,interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:AllRecommend.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func genre(page:Int,type:String) -> AnyPublisher<GenreRecommend,AFError>{
        print("장르 기반 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.genre(page: page,type: type),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:GenreRecommend.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func activity(page:Int,contentsId:Int) -> AnyPublisher<ActivityRecommend,AFError>{
        print("활동 기반 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.activity(page: page,contentsId:contentsId),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:ActivityRecommend.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func imad(page:Int,type:String,category:String) -> AnyPublisher<ImadRecommend,AFError>{
        print("Imad 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.imad(page: page,type: type,category: category),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:ImadRecommend.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func trend(page:Int,type:String) -> AnyPublisher<TrendRecommend,AFError>{
        print("대세 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.trend(page: page,type: type),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:TrendRecommend.self)
            .value()
            .eraseToAnyPublisher()
    }
}
