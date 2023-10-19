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
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .addReply:
            return .post
        case .modifyReply:
            return .patch
        case .deleteReply:
            return .delete
        }
    }
    var parameters:Parameters{
        switch self{
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
        case .deleteReply:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        return try JSONEncoding.default.encode(request, with: parameters)
        
    }
}
