//
//  WorkApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/09.
//

import Foundation
import Combine
import Alamofire

enum WorkApiService{
    
    static var intercept = BaseIntercept()
    
    static func workSearch(query:String,type:String,page:Int) -> AnyPublisher<Work,AFError>{
        print("작품검사 api호출")
        return ApiClient.shared.session
            .request(WorkRouter.workSearch(query: query, type: type, page: page),interceptor: intercept)
            .publishDecodable(type: Work.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
}
