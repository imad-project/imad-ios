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
    case genre(page:Int,type:String)
    case activity(page:Int,contentsId:Int)
    case imad(page:Int,type:String,category:String)
    case trend(page:Int,type:String)
    
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
        case let .genre(page,type):
            var params = Parameters()
            params["page"] = page
            params["type"] = type
            return params
        case let .activity(page,contentsId):
            var params = Parameters()
            params["contents_id"] = contentsId
            params["page"] = page
            return params
        case let .imad(page,type,category):
            var params = Parameters()
            params["page"] = page
            params["type"] = type
            params["category"] = category
            return params
        case let .trend(page,type):
            var params = Parameters()
            params["page"] = page
            params["type"] = type
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
