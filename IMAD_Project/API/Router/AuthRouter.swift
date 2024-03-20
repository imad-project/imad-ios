//
//  AuthRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Alamofire

enum AuthRouter:URLRequestConvertible{
    
    
    case register(email:String,password:String,authProvider:String)
    case login(email:String,password:String)
    case oauthDelete(authProvider:String)
    case appleLogin(state:String?,code:String,user:String,idToken:String)
    case delete
   
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .login:
            return "/api/login"
        case .register:
            return "/api/signup"
        case .delete:
            return "/api/user"
        case .oauthDelete(let authProvier):
            return "/api/oauth2/revoke/\(authProvier)"
        case .appleLogin:
            return "/api/callback/apple/token"
        }
    }
    var method:HTTPMethod{
        switch self{
        case .login,.register,.appleLogin:
            return .post
        case .delete,.oauthDelete:
            return .delete
        }
    }
    var parameters:Parameters{
        switch self{
        case let .login(email,password):
            var param = Parameters()
            param["email"] = email
            param["password"] = password
            return param
        case let .register(email, password,authProvider):
            var param = Parameters()
            param["email"] = email
            param["password"] = password
            param["auth_provider"] = authProvider
            return param
        case let .appleLogin(state, code, user, idToken):
            var params = Parameters()
            params["state"] = state
            params["code"] = code
            params["user"] = user
            params["id_token"] = idToken
            return params
        case .delete,.oauthDelete:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .login,.register,.appleLogin:
            return try JSONEncoding.default.encode(request, with: parameters)
        case .delete,.oauthDelete:
            return request
        }
    }
}


