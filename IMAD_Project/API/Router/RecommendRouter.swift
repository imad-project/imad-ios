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
    case list(page:Int,type:String,contentsId:Int?,category:String?,recommendCateogry:RecommendFilter)
    
    var baseURL:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var method:HTTPMethod{
        return .get
    }
    var endPoint:String{
        switch self{
        case .all : return "/api/recommend/all"
        case let .list(_,_,_,_,recommendListType): return "/api/recommend/\(recommendListType.endPoint)"
        }
    }
    var parameters:Parameters{
        switch self{
        case .all: return Parameters()
        case let .list(page,type,contentsId,category,_):
            var params = Parameters()
            params["page"] = page
            params["type"] = type
            if let contentsId{  params["contents_id"] = contentsId }
            if let category{ params["category"] = category }
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
