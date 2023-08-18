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
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .workSearch:
            return "/api/contents/search"
        case .workInfo:
            return "/api/contents/details"
        }
    }
    var method:HTTPMethod{
        switch self{
        case .workSearch,.workInfo:
            return .get
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
        }
        
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        
        switch self{
        case .workSearch, .workInfo:
            let encoding = URLEncoding(destination: .queryString)
            return try encoding.encode(request, with: parameters)
        }
        // 인코딩 설정 변경
        
    }
   


}
