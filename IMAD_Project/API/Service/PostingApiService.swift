//
//  CommunityApiService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation
import Alamofire
import Combine

class PostingApiService{
    
    static var intercept = BaseIntercept()
    
    static func writeCommunity(contentsId:Int,title:String,content:String,category:Int,spoiler:Bool) -> AnyPublisher<NetworkResponse<CreatePostingResponse>,AFError>{
        print("게시물작성 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.write(contentsId: contentsId, title: title, content: content, category: category, spoiler: spoiler),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<CreatePostingResponse>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func readAllCommunityList(page:Int,category:Int) -> AnyPublisher<NetworkResponse<NetworkListResponse<PostingResponse>>,AFError>{
        print("게시물 전체리스트 조회 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.readListAll(page:page,category:category),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<NetworkListResponse<PostingResponse>>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func readListConditionsAll(searchType:Int,query:String,page:Int,sort:String,order:Int,category:Int) -> AnyPublisher<NetworkResponse<NetworkListResponse<PostingResponse>>,AFError>{
        print("게시물 조건 전체리스트 조회 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.readListConditionsAll(searchType:searchType,query:query,page:page,sort:sort,order:order,category:category),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<NetworkListResponse<PostingResponse>>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func readPosting(postingId:Int) -> AnyPublisher<NetworkResponse<PostingResponse>,AFError>{
        print("게시물 상세 조회 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.readPosting(postingId: postingId),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<PostingResponse>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func postingLike(postingId:Int,status:Int) -> AnyPublisher<NetworkResponse<Int>,AFError>{
        print("게시물 좋아요/싫어요 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.like(postingId: postingId, status: status),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<Int>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func modifyCommunity(postingId:Int,title:String,content:String,category:Int,spoiler:Bool) -> AnyPublisher<NetworkResponse<CreatePostingResponse>,AFError>{
        print("게시물수정 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.modify(postingId: postingId, title: title, content: content, category: category, spoiler: spoiler),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<CreatePostingResponse>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func deletePosting(postingId:Int) -> AnyPublisher<NetworkResponse<Int>,AFError>{
        print("게시물 삭제 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.delete(postingId: postingId),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<Int>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
  
    static func myCommunity(page:Int) -> AnyPublisher<NetworkResponse<NetworkListResponse<PostingResponse>>,AFError>{
        print("내 게시물 조회 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.myCommunity(page: page),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<NetworkListResponse<PostingResponse>>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
    static func myLikeCommunity(page:Int,likeStatus:Int) -> AnyPublisher<NetworkResponse<NetworkListResponse<PostingResponse>>,AFError>{
        print("내 좋아요/싫어요 게시물 조회 api호출")
        return ApiClient.shared.session
            .request(CommunityRouter.myLikeCommunity(page: page, likeStatus: likeStatus),interceptor: intercept)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: NetworkResponse<NetworkListResponse<PostingResponse>>.self)
            .value()
            .map{ receivedValue in
                print("결과 메세지  : \(receivedValue.message)")
                return receivedValue.self
            }
            .eraseToAnyPublisher()
    }
}
