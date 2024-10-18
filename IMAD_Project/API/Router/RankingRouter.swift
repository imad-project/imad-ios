//
//  RankingRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 1/8/24.
//

import Foundation
import Alamofire

enum RankingRouter:URLRequestConvertible{
   
    case ranking(endPoint:String,page:Int,mediaType:String)
    case popularPosting
    case popularReivew
   
    
    var baseURL:URL{
        return URL(string: ApiClient.baseURL)!
    }
    var method:HTTPMethod{
        return .get
    }
    var endPoint:String{
        switch self{
        case let .ranking(endPoint,_,_):
            return "/api/ranking/\(endPoint)"
        case .popularReivew:
            return "/api/popular/review"
        case .popularPosting:
            return "/api/popular/posting"
        }
    }
    var parameters:Parameters{
        switch self{
        case let .ranking(_,page, type):
            var parms =  Parameters()
            parms["page"] = page
            parms["type"] = type
            return parms
        case .popularReivew,.popularPosting:
            return Parameters()
        }
    }

    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return try URLEncoding(destination: .queryString).encode(request, with: parameters)
    }
}

