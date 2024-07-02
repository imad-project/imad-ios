//
//  RecommendRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 6/24/24.
//

import Foundation
import Alamofire

enum RecommendRouter:URLRequestConvertible{
    
    case all
    case genre(page:Int)
    case activity(page:Int,contentsId:Int)
    case imad(page:Int)
    case trend(page:Int)
    
    var baseURL:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var method:HTTPMethod{
        return .get
    }
    var endPoint:String{
        switch self{
        case .all : return "/api/recommend/all"
        case .genre : return "/api/recommend/genre"
        case .activity : return "/api/recommend/activity"
        case .imad : return "/api/recommend/imad"
        case .trend : return "/api/recommend/trend"
        }
    }
    var parameters:Parameters{
        switch self{
        case .all: return Parameters()
        case let .genre(page):
            var params = Parameters()
            params["page"] = page
            return params
        case let .activity(page,contentsId):
            var params = Parameters()
            params["contents_id"] = contentsId
            params["page"] = page
            return params
        case let .imad(page):
            var params = Parameters()
            params["page"] = page
            return params
        case let .trend(page):
            var params = Parameters()
            params["page"] = page
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return try URLEncoding(destination: .queryString).encode(request, with: parameters)
    }
}
