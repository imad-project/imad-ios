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
    case readList(id:Int,page:Int,sort:String,order:Int)
    case like(id:Int,status:Int)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .write:
            return "/api/review"
        case  .read(let id),.update(let id),.delete(let id):
            return "/api/review/\(id)"
        case .readList(let id,_,_,_):
            return "/api/review/list/\(id)"
        case .like(let id,_):
            return "/api/review/\(id)/like"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .write:
            return .post
        case .read,.readList:
            return .get
        case .update,.like:
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
        case let .readList(_, page, sort, order):
            var params = Parameters()
            params["page"] = page
            params["sort"] = sort
            params["order"] = order
            return params
        case let .like(_,status):
            var params = Parameters()
            params["like_status"] = status
            return params
        default:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .readList:
            return try URLEncoding(destination: .queryString).encode(request, with: parameters)
        default:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
        
    }
}
