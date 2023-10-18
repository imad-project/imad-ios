//
//  WorkRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/08/09.
//

import Foundation
import Alamofire

enum WorkRouter:URLRequestConvertible{
    case workSearch(query:String,type:String,page:Int)
    case workInfo(id:Int,type:String)
    case workDetailInfo(contentsId:Int)
    case bookmarkRead(page:Int)
    case bookmarkCreate(id:Int)
    case bookmarkDelete(id:Int)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .workSearch:
            return "/api/contents/search"
        case .workInfo:
            return "/api/contents/details"
        case let .workDetailInfo(contentsId):
            return "/api/contents/\(contentsId)"
        case .bookmarkRead:
            return "/api/profile/bookmark/list"
        case .bookmarkCreate:
            return "/api/profile/bookmark"
        case let .bookmarkDelete(id):
            return "/api/profile/bookmark/\(id)"
        }
    }
    var method:HTTPMethod{
        switch self{
        case .workSearch,.workInfo,.bookmarkRead,.workDetailInfo:
            return .get
        case .bookmarkCreate:
            return .post
        case .bookmarkDelete:
            return .delete
        }
        
    }
    var parameters:Parameters{
        switch self{
        case let .workSearch(query,type,page):
            var params = Parameters()
            params["query"] = query
            params["type"] = type
            params["page"] = page
            return params
        case let .workInfo(id, type):
            var params = Parameters()
            params["id"] = id
            params["type"] = type
            return params
        case let .bookmarkCreate(id):
            var params = Parameters()
            params["contents_id"] = id
            return params
        case let .bookmarkRead(page):
            var params = Parameters()
            params["page"] = page
            return params
        case .bookmarkDelete,.workDetailInfo:
            return Parameters()
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        
        switch self{
        case .workSearch, .workInfo,.bookmarkRead,.bookmarkDelete,.workDetailInfo:
            let encoding = URLEncoding(destination: .queryString)
            return try encoding.encode(request, with: parameters)
        case  .bookmarkCreate:
            return try JSONEncoding.default.encode(request, with: parameters)
            
        }
        // 인코딩 설정 변경
        
    }
   


}
