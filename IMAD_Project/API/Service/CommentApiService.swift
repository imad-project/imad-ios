//
//  RouterApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/19.
//

import Foundation
import Alamofire
import Combine

class CommentApiService{
    static var intercept = BaseIntercept()
    
    static func addReply(postingId:Int,parentId:Int?,content:String) -> AnyPublisher<AddComment,AFError>{
        print("댓글 작성 api호출")
        return ApiClient.shared.session
            .request(ReplyRouter.addReply(postingId: postingId, parentId: parentId, content: content),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: AddComment.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func modifyReply(commentId:Int,content:String) -> AnyPublisher<AddComment,AFError>{
        print("댓글 수정 api호출")
        return ApiClient.shared.session
            .request(ReplyRouter.modifyReply(commentId: commentId, content: content),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: AddComment.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func deleteReply(commentId:Int) -> AnyPublisher<AddComment,AFError>{
        print("댓글 삭제 api호출")
        return ApiClient.shared.session
            .request(ReplyRouter.deleteReply(commentId: commentId),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: AddComment.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func readListReply(postingId:Int,commentType:Int,page:Int,sort:String,order:Int,parentId:Int)-> AnyPublisher<CommentList,AFError>{
        print("댓글 리스트 api호출")
        return ApiClient.shared.session
            .request(ReplyRouter.readReplyList(postingId:postingId,commentType:commentType,page:page,sort:sort,order:order,parentId:parentId),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: CommentList.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func like(commentId:Int,likeStatus:Int)-> AnyPublisher<NoDataResponse,AFError>{
        print("댓글 좋아요/싫어요 api호출")
        return ApiClient.shared.session
            .request(ReplyRouter.like(commentId: commentId, likeStatus: likeStatus),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NoDataResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
