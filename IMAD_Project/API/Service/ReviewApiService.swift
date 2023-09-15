//
//  ReviewApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import Foundation
import Combine
import Alamofire

enum ReviewApiService{
    
    static var intercept = BaseIntercept()
    
    static func reviewWrite(id:Int,title:String,content:String,score:Double,spoiler:Bool) -> AnyPublisher<WriteReview,AFError>{
        print("리뷰작성 api호출")
        return ApiClient.shared.session
            .request(ReivewRouter.write(id: id, title: title, content: content, score: score, spoiler: spoiler),interceptor: intercept)
            .publishDecodable(type: WriteReview.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func reviewRead(id:Int) -> AnyPublisher<ReadReview,AFError>{
        print("리뷰조회 api호출")
        return ApiClient.shared.session
            .request(ReivewRouter.read(id: id),interceptor: intercept)
            .publishDecodable(type: ReadReview.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func reviewUpdate(id:Int) -> AnyPublisher<UpdateReview,AFError>{
        print("리뷰수정 api호출")
        return ApiClient.shared.session
            .request(ReivewRouter.update(id: id),interceptor: intercept)
            .publishDecodable(type: UpdateReview.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func reviewDelete(id:Int) -> AnyPublisher<DeleteReview,AFError>{
        print("리뷰삭제 api호출")
        return ApiClient.shared.session
            .request(ReivewRouter.delete(id: id),interceptor: intercept)
            .publishDecodable(type: DeleteReview.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func reviewReadList(id:Int,page:Int,sort:String,order:Int) -> AnyPublisher<ReadReviewList,AFError>{
        print("리뷰리스트 조회")
        return ApiClient.shared.session
            .request(ReivewRouter.readList(id: id, page: page, sort: sort, order: order),interceptor: intercept)
            .publishDecodable(type: ReadReviewList.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
