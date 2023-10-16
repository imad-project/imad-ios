//
//  CommunityApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation
import Alamofire
import Combine

class CommunityApiService{
    
    static var intercept = BaseIntercept()
    
    static func writeCommunity(contentsId:Int,title:String,content:String,category:Int,spoiler:Bool) -> AnyPublisher<CommunityResponse,AFError>{
        print("게시물작성 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.write(contentsId: contentsId, title: title, content: content, category: category, spoiler: spoiler),interceptor: intercept)
            .publishDecodable(type: CommunityResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func readAllCommunityList(page:Int) -> AnyPublisher<CommunityList,AFError>{
        print("게시물 전체리스트 조회 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.readListAll(page:page),interceptor: intercept)
            .publishDecodable(type: CommunityList.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
