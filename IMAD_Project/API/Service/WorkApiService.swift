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
    
    static func workSearch(query:String,type:String,page:Int) -> AnyPublisher<SearchWork,AFError>{
        print("작품검색 api호출")
        return ApiClient.shared.session
            .request(WorkRouter.workSearch(query: query, type: type, page: page),interceptor: intercept)
            .publishDecodable(type: SearchWork.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
    static func workInfo(id:Int,type:String) -> AnyPublisher<Work,AFError>{
        print("작품상세정보 api호출")
        return ApiClient.shared.session
            .request(WorkRouter.workInfo(id: id, type: type),interceptor: intercept)
            .publishDecodable(type: Work.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func workInfo(contentsId:Int) -> AnyPublisher<Work,AFError>{
        print("작품상세정보 api호출")
        return ApiClient.shared.session
            .request(WorkRouter.workDetailInfo(contentsId: contentsId),interceptor: intercept)
            .publishDecodable(type: Work.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func bookRead(page:Int) -> AnyPublisher<Bookmark,AFError>{
        print("북마크 조회 api호출")
        return ApiClient.shared.session
            .request(WorkRouter.bookmarkRead(page: page),interceptor: intercept)
            .publishDecodable(type: Bookmark.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func bookCreate(id:Int) -> AnyPublisher<Bookmark,AFError>{
        print("북마크 추가 api호출")
        return ApiClient.shared.session
            .request(WorkRouter.bookmarkCreate(id:id),interceptor: intercept)
            .publishDecodable(type: Bookmark.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func bookDelete(id:Int) -> AnyPublisher<Bookmark,AFError>{
        print("북마크 삭제 api호출")
        return ApiClient.shared.session
            .request(WorkRouter.bookmarkDelete(id:id),interceptor: intercept)
            .publishDecodable(type: Bookmark.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    
}
