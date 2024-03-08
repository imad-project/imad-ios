//
//  RankingRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 1/8/24.
//

import Foundation
import Alamofire

enum RankingRouter:URLRequestConvertible{
   
    case all(page:Int,type:String)
    case week(page:Int,type:String)
    case month(page:Int,type:String)
   
    
    var baseURL:URL{
        return URL(string: ApiClient.baseURL)!
    }
    var method:HTTPMethod{
        return .get
    }
    var endPoint:String{
        switch self{
        case .week:
            return "/api/weekly"
        case .month:
            return "/api/monthly"
        case .all:
            return "/api/alltime"
        }
    }
    var parameters:Parameters{
        switch self{
        case let .week(page, type):
            var parms =  Parameters()
            parms["page"] = page
            parms["type"] = type
            return parms
        case let .month(page, type):
            var parms =  Parameters()
            parms["page"] = page
            parms["type"] = type
            return parms
        case let .all(page, type):
            var parms =  Parameters()
            parms["page"] = page
            parms["type"] = type
            return parms
        }
    }

    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return try URLEncoding(destination: .queryString).encode(request, with: parameters)
    }
}

