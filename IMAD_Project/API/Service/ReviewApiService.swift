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
            .request(ReviewRouter.write(id: id, title: title, content: content, score: score, spoiler: spoiler),interceptor: intercept)
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
            .request(ReviewRouter.read(id: id),interceptor: intercept)
            .publishDecodable(type: ReadReview.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func reviewUpdate(id:Int,title:String,content:String,score:Double,spoiler:Bool) -> AnyPublisher<UpdateReview,AFError>{
        print("리뷰수정 api호출")
        return ApiClient.shared.session
            .request(ReviewRouter.update(id: id, title: title, content: content, score: score, spoiler: spoiler),interceptor: intercept)
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
            .request(ReviewRouter.delete(id: id),interceptor: intercept)
            .publishDecodable(type: DeleteReview.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func reviewReadList(id:Int,page:Int,sort:String,order:Int) -> AnyPublisher<ReadReviewList,AFError>{
        print("리뷰리스트 조회 호출")
        return ApiClient.shared.session
            .request(ReviewRouter.readList(id: id, page: page, sort: sort, order: order),interceptor: intercept)
            .publishDecodable(type: ReadReviewList.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func reviewLike(id:Int,status:Int) -> AnyPublisher<ReviewLike,AFError>{
        print("리뷰 좋아요/싫어요 호출")
        return ApiClient.shared.session
            .request(ReviewRouter.like(id: id, status: status),interceptor: intercept)
            .publishDecodable(type: ReviewLike.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func myReview(page:Int) -> AnyPublisher<ReadReviewList,AFError>{
        print("내 리뷰 리스트 호출")
        return ApiClient.shared.session
            .request(ReviewRouter.myReview(page: page),interceptor: intercept)
            .publishDecodable(type: ReadReviewList.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func myLikeReview(page:Int) -> AnyPublisher<ReadReviewList,AFError>{
        print("내 좋아요/싫어요 리뷰 리스트 호출")
        return ApiClient.shared.session
            .request(ReviewRouter.myLikeReview(page: page),interceptor: intercept)
            .publishDecodable(type: ReadReviewList.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
