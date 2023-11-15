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
    
    static func writeCommunity(contentsId:Int,title:String,content:String,category:Int,spoiler:Bool) -> AnyPublisher<WriteCommnunity,AFError>{
        print("게시물작성 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.write(contentsId: contentsId, title: title, content: content, category: category, spoiler: spoiler),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: WriteCommnunity.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func readAllCommunityList(page:Int,category:Int) -> AnyPublisher<CommunityList,AFError>{
        print("게시물 전체리스트 조회 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.readListAll(page:page,category:category),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: CommunityList.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func readListConditionsAll(searchType:Int,query:String,page:Int,sort:String,order:Int) -> AnyPublisher<CommunityList,AFError>{
        print("게시물 조건 전체리스트 조회 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.readListConditionsAll(searchType:searchType,query:query,page:page,sort:sort,order:order),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: CommunityList.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func readPosting(postingId:Int) -> AnyPublisher<Community,AFError>{
        print("게시물 상세 조회 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.readPosting(postingId: postingId),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: Community.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func postingLike(postingId:Int,status:Int) -> AnyPublisher<NoDataResponse,AFError>{
        print("게시물 좋아요/싫어요 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.like(postingId: postingId, status: status),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NoDataResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func modifyCommunity(postingId:Int,title:String,content:String,category:Int,spoiler:Bool) -> AnyPublisher<WriteCommnunity,AFError>{
        print("게시물수정 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.modify(postingId: postingId, title: title, content: content, category: category, spoiler: spoiler),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: WriteCommnunity.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func deletePosting(postingId:Int) -> AnyPublisher<NoDataResponse,AFError>{
        print("게시물 삭제 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.delete(postingId: postingId),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NoDataResponse.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func readComment(commentId:Int) -> AnyPublisher<Comment,AFError>{
        print("게시물 댓글 조회 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.readComment(commentId: commentId),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: Comment.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
