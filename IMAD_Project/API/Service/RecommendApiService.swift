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
    
    static func all() -> AnyPublisher<NetworkResponse<AllRecommendResponse>,AFError>{
        print("전체 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.all,interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:NetworkResponse<AllRecommendResponse>.self)
            .value()
            .eraseToAnyPublisher()
    }
    static func list<T:Decodable>(page:Int,type:String,contentsId:Int? = nil,category:String? = nil,recommendCategory:RecommendCategory) -> AnyPublisher<T,AFError>{
        print("\(recommendCategory.endPoint) 작품 추천 api 호출")
        return ApiClient.shared.session
            .request(RecommendRouter.list(page: page, type: type, contentsId: contentsId, category: category, recommendCateogry: recommendCategory),interceptor: interseptor)
            .validate(statusCode: 200..<300)
            .publishDecodable(type:T.self)
            .value()
            .eraseToAnyPublisher()
    }
}
