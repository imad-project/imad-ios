//
//  AuthRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Alamofire

enum AuthRouter:URLRequestConvertible{
    
    
    case register(email:String,nickname:String,password:String,authProvider:String)
    case login(email:String,password:String)
//    case oauth(registrationId:String)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .login:
            return "/api/login"
        case .register:
            return "/api/signup"
//        case let .oauth(registrationId):
//            return "/login/oauth2/code/\(registrationId)"
        }
    }
    var method:HTTPMethod{
        switch self{
        case .login,.register:
            return .post
//        case .oauth:
//            return .get
        }
    }
    var parameters:Parameters{
        switch self{
        case let .login(email,password):
            var param = Parameters()
            param["email"] = email
            param["password"] = password
            return param
        case let .register(email, nickname, password,authProvider):
            var param = Parameters()
            param["email"] = email
            param["nickname"] = nickname
            param["password"] = password
            param["auth_provider"] = authProvider
            return param
//        case .oauth:
//            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .login,.register:
            return try JSONEncoding.default.encode(request, with: parameters)
//        case .oauth:
//            return request
        }
    }
}
