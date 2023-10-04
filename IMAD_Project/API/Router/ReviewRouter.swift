//
//  ReviewRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import Foundation
import Alamofire

enum ReviewRouter:URLRequestConvertible{
    case write(id:Int,title:String,content:String,score:Double,spoiler:Bool)
    case read(id:Int)
    case update(id:Int,title:String,content:String,score:Double,spoiler:Bool)
    case delete(id:Int)
    case readList(id:Int,page:Int,sort:String,order:Int)
    case like(id:Int,status:Int)
    case myReview(page:Int)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .write:
            return "/api/review"
        case  .read(let id),.update(let id,_,_,_,_),.delete(let id):
            return "/api/review/\(id)"
        case .readList:
            return "/api/review/list"
        case .like(let id,_):
            return "/api/review/like/\(id)"
        case .myReview:
            return "api/profile/review/list"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .write:
            return .post
        case .read,.readList,.myReview:
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
        case let .readList(id, page, sort, order):
            var params = Parameters()
            params["contents_id"] = id
            params["page"] = page
            params["sort"] = sort
            params["order"] = order
            return params
        case let .update(id, title, content, score, spoiler):
            var params = Parameters()
            params["contents_id"] = id
            params["title"] = title
            params["content"] = content
            params["score"] = score
            params["is_spoiler"] = spoiler
            return params
        case let .like(_,status):
            var params = Parameters()
            params["like_status"] = status
            return params
        case let .myReview(page):
            var params = Parameters()
            params["page"] = page
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
        case .readList,.read,.delete,.myReview:
            return try URLEncoding(destination: .queryString).encode(request, with: parameters)
        default:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
        
    }
}
