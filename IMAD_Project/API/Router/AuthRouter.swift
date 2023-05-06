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
    
    var baseUrl:URL{
        return URL(string: "")!
    }
    
    var endPoint:String{
        switch self{
        case .login:
            return ""
        case .register:
            return ""
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
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
