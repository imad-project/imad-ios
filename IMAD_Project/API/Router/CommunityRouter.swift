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
    case readListAll(page:Int,category:Int)
    case readListConditionsAll(searchType:Int,query:String,page:Int,sort:String,order:Int,category:Int)
    case readPosting(postingId:Int)
    case like(postingId:Int,status:Int)
    case modify(postingId:Int,title:String,content:String,category:Int,spoiler:Bool)
    case delete(postingId:Int)
    
    case myCommunity(page:Int)
    case myLikeCommunity(page:Int,likeStatus:Int)
    
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
        case let .modify(postingId,_,_,_,_):
            return "/api/posting/\(postingId)"
        case let .delete(postingId):
            return "/api/posting/\(postingId)"        case .myCommunity:
            return "/api/profile/posting/list"
        case .myLikeCommunity:
            return "/api/profile/like/posting/list"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .write:
            return .post
        case .readListAll,.readListConditionsAll,.readPosting,.myCommunity,.myLikeCommunity:
            return .get
        case .like,.modify:
            return .patch
        case .delete:
            return .delete
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
        case let .readListAll(page,category):
            var params = Parameters()
            params["page"] = page
            params["category"] = category
            return params
        case let .readListConditionsAll(searchType, query, page, sort, order,category):
            var params = Parameters()
            params["search_type"] = searchType
            params["query"] = query
            params["page"] = page
            params["sort"] = sort
            params["order"] = order
            params["category"] = category
            return params
        case let .like(_, status):
            var params = Parameters()
            params["like_status"] = status
            return params
        case let .modify(_, title, content, category, spoiler):
            var params = Parameters()
            params["title"] = title
            params["content"] = content
            params["category"] = category
            params["is_spoiler"] = spoiler
            return params
        case let .myCommunity(page):
            var params = Parameters()
            params["page"] = page
            return params
        case let .myLikeCommunity(page,likeStatus):
            var params = Parameters()
            params["page"] = page
            params["like_status"] = likeStatus
            return params
        case .readPosting,.delete:
            return Parameters()
        
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .readListAll,.readListConditionsAll,.readPosting,.delete,.myCommunity,.myLikeCommunity:
            return try URLEncoding(destination: .queryString).encode(request, with: parameters)
        case .write,.like,.modify:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
        
    }
    
}
