//
//  AuthRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Alamofire

enum AuthRouter:URLRequestConvertible{
    
    
    case register(email:String,id:String,password:String)
    case login(id:String,password:String)
    case kakao(code:String,statua:Int)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .login:
            return ""
        case .register:
            return ""
        case .kakao:
            return "/login/oauth2/code/kakao"
        }
    }
    var method:HTTPMethod{
        return .post
    }
    var parameters:Parameters{
        switch self{
        case let .login(id,password):
            var param = Parameters()
            param["id"] = id
            param["password"] = password
            return param
        case let .register(email, id, password):
            var param = Parameters()
            param["email"] = email
            param["id"] = id
            param["password"] = password
            return param
        case let .kakao(code, status):
            var param = Parameters()
            param["code"] = code
            param["status"] = status
            return param
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
