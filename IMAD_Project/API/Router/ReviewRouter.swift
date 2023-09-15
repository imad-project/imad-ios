//
//  ReviewRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import Foundation
import Alamofire

enum ReivewRouter:URLRequestConvertible{
    case write(id:Int,title:String,content:String,score:Double,spoiler:Bool)
    case read(id:Int)
    case update(id:Int)
    case delete(id:Int)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .write:
            return "/api/review"
        case  .read(let id),.update(let id),.delete(let id):
            return "/api/review/\(id)"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .write:
            return .post
        case .read:
            return .get
        case .update:
            return .patch
        case .delete:
            return .delete
        }
    }
    var parameters:Parameters{
        switch self{
        case let .write(id, title, content, score, spoiler):
            var params = Parameters()
            params["contents_id"] = id
            params["title"] = title
            params["content"] = content
            params["score"] = score
            params["is_spoiler"] = spoiler
            return params
        default:
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
