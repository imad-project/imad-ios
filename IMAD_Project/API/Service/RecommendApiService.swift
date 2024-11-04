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
    static func list<T:Decodable>(page:Int,type:String,contentsId:Int? = nil,category:String? = nil,recommendListType:RecommendListType) -> AnyPublisher<T,AFError>{
        print("\(recommendListType.endPoint) 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.list(page: page, type: type, contentsId: contentsId, category: category, recommendListType: recommendListType),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:T.self)
            .value()
            .eraseToAnyPublisher()
    }
}
