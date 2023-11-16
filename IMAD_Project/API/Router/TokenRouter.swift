//
//  TokenRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/03.
//

import Foundation
import Alamofire

enum TokenRouter:URLRequestConvertible{
    case token
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    var endPoint:String{
        return "/api/token"
    }
    var method:HTTPMethod{
            return .get
        
    }
    var parameters:Parameters{
            return Parameters()
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        return request
    }
}
