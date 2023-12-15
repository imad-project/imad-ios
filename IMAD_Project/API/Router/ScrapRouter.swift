//
//  ScrapRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/22.
//

import Foundation
import Alamofire

enum ScrapRouter:URLRequestConvertible{
    case read(page:Int)
    case write(postingId:Int)
    case delete(scrapId:Int)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    var endPoint:String{
        switch self{
        case .read:
            return "/api/profile/scrap/list"
        case .write:
            return "/api/profile/scrap"
        case let .delete(scrapId):
            return "/api/profile/scrap/\(scrapId)"
        }
    }
    var method:HTTPMethod{
        switch self{
        case .read:
            return .get
        case .write:
            return .post
        case .delete:
            return .delete
        }
        
    }
    var parameters:Parameters{
        switch self{
        case let .read(page):
            var params = Parameters()
            params["page"] = page
            return params
        case let .write(postingId):
            var params = Parameters()
            params["posting_id"] = postingId
            return params
        case .delete:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .read,.delete:
            return try URLEncoding(destination: .queryString).encode(request, with: parameters)
        case .write:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
    }
}
