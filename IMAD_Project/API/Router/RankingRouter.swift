//
//  RankingRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 1/8/24.
//

import Foundation
import Alamofire

enum RankingRouter:URLRequestConvertible{
   
    case all
    case week
    case month
   
    
    var baseURL:URL{
        return URL(string: ApiClient.baseURL)!
    }
    var method:HTTPMethod{
        return .get
    }
    var endPoint:String{
        switch self{
        case .week:
            return "/api/ranking/weekly/all"
        case .month:
            return "/api/ranking/monthly/all"
        case .all:
            return "/api/ranking/alltime/all"
        }
    }
    var parameters:Parameters{
        return Parameters()
    }

    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return try URLEncoding(destination: .queryString).encode(request, with: parameters)
    }
}
