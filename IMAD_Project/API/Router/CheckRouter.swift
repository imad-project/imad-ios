//
//  CheckRoute.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/28.
//

import Foundation
import Alamofire

enum CheckRouter:URLRequestConvertible{
    
    case checkNickname(nickname:String)
    case checkEmail(email:String)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .checkEmail:
             return "/api/user/validation/email"
        case .checkNickname:
            return "/api/user/validation/nickname"
        }
    }
    var method:HTTPMethod{
        return .post
    }
    var parameters:Parameters{
        switch self{
        case let .checkEmail(email):
            var params = Parameters()
            params["info"] = email
            return params
            
        case let .checkNickname(nickname):
            var params = Parameters()
            params["info"] = nickname
            return params
        }
    }
    func asURLRequest() throws -> URLRequest {
        
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        
        return try JSONEncoding.default.encode(request, with: parameters)
    }
}
