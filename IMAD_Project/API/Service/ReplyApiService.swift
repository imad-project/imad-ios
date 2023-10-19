//
//  RouterApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/19.
//

import Foundation
import Alamofire
import Combine

class ReplyApiService{
    static var intercept = BaseIntercept()
    
    static func addReply(postingId:Int,parentId:Int?,content:String) -> AnyPublisher<AddCommentResponse,AFError>{
        print("댓글 작성 api호출")
        return ApiClient.shared.session
            .request(ReplyRouter.addReply(postingId: postingId, parentId: parentId, content: content),interceptor: intercept)
            .publishDecodable(type: AddCommentResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func modifyReply(commentId:Int,content:String) -> AnyPublisher<AddCommentResponse,AFError>{
        print("댓글 수정 api호출")
        return ApiClient.shared.session
            .request(ReplyRouter.modifyReply(commentId: commentId, content: content),interceptor: intercept)
            .publishDecodable(type: AddCommentResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func deleteReply(commentId:Int) -> AnyPublisher<AddCommentResponse,AFError>{
        print("댓글 삭제 api호출")
        return ApiClient.shared.session
            .request(ReplyRouter.deleteReply(commentId: commentId),interceptor: intercept)
            .publishDecodable(type: AddCommentResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
