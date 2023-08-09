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
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .workSearch:
            return "/api/contents/search"
        }
    }
    var method:HTTPMethod{
        switch self{
        case .workSearch:
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
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .workSearch:
            return try URLEncoding.default.encode(request, with: parameters)
        }
    }
}
