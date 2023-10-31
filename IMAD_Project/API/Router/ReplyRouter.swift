//
//  ReplyRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/19.
//

import Foundation
import Alamofire

enum ReplyRouter:URLRequestConvertible{
    case addReply(postingId:Int,parentId:Int?,content:String)
    case modifyReply(commentId:Int,content:String)
    case deleteReply(commentId:Int)
    case readReplyList(postingId:Int,commentType:Int,page:Int,sort:String,order:Int,parentId:Int)
    case like(commentId:Int,likeStatus:Int)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .addReply:
            return "/api/posting/comment"
        case let .modifyReply(commentId,_):
            return "/api/posting/comment/\(commentId)"
        case let .deleteReply(commentId):
            return "/api/posting/comment/\(commentId)"
        case .readReplyList:
            return "/api/posting/comment/list"
        case let .like(commentId,_):
            return "/api/posting/comment/like/\(commentId)"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .readReplyList:
            return .get
        case .addReply:
            return .post
        case .modifyReply,.like:
            return .patch
        case .deleteReply:
            return .delete
        
        }
    }
    var parameters:Parameters{
        switch self{
        case let.readReplyList(postingId, commentType, page, sort, order, parentId):
            var params = Parameters()
            params["posting_id"] = postingId
            params["parent_id"] = parentId
            params["comment_type"] = commentType
            params["page"] = page
            params["sort"] = sort
            params["order"] = order
            return params
        case let .addReply(postingId, parentId, content):
            var params = Parameters()
            params["posting_id"] = postingId
            params["parent_id"] = parentId
            params["content"] = content
            return params
        case let .modifyReply(_, content):
            var params = Parameters()
            params["content"] = content
            return params
        case let .like(_, likeStatus):
            var params = Parameters()
            params["like_status"] = likeStatus
            return params
        case .deleteReply:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .readReplyList:
            return try URLEncoding(destination: .queryString).encode(request, with: parameters)
        default:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
    }
}
