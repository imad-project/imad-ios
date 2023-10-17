//
//  CommunityRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation
import Alamofire

enum CommunityRouter:URLRequestConvertible{
    
    case write(contentsId:Int,title:String,content:String,category:Int,spoiler:Bool)
    case readListAll(page:Int)
    case readListConditionsAll(searchType:Int,query:String,page:Int,sort:String,order:Int)
    case readPosting(postingId:Int)
    case like(postingId:Int,status:Int)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .write:
            return "/api/posting"
        case .readListAll:
            return "/api/posting/list"
        case .readListConditionsAll:
            return "/api/posting/list/search"
        case let .readPosting(postingId):
            return "/api/posting/\(postingId)"
        case let .like(postingId,_):
            return "/api/posting/like/\(postingId)"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .write:
            return .post
        case .readListAll,.readListConditionsAll,.readPosting:
            return .get
        case .like:
            return .patch
        }
    }
    
    var parameters:Parameters{
        switch self{
        case let .write(contentsId, title, content, category, spoiler):
            var params = Parameters()
            params["contents_id"] = contentsId
            params["title"] = title
            params["content"] = content
            params["category"] = category
            params["is_spoiler"] = spoiler
            return params
        case let .readListAll(page):
            var params = Parameters()
            params["page"] = page
            return params
        case let .readListConditionsAll(searchType, query, page, sort, order):
            var params = Parameters()
            params["search_type"] = searchType
            params["query"] = query
            params["page"] = page
            params["sort"] = sort
            params["order"] = order
            return params
        case .readPosting:
            return Parameters()
        case let .like(_, status):
            var params = Parameters()
            params["like_status"] = status
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .readListAll,.readListConditionsAll,.readPosting:
            return try URLEncoding(destination: .queryString).encode(request, with: parameters)
        case .write,.like:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
        
    }
    
}
