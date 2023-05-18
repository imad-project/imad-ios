//
//  UserRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/16.
//

import Foundation
import Alamofire

enum UserRouter:URLRequestConvertible{
    case user(userId:Int)
    case patchUser(gender:String?,ageRange:Int?,image:Int,nickname:String,genre:String?,userId:Int)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case let .user(userId):
            return "/api/user/\(userId)"
        case let .patchUser(_,_,_,_,_,userId):
            return "/api/user/\(userId)"
        }
    }
    var method:HTTPMethod{
        switch self{
        case .user:
            return .get
        case .patchUser:
            return .patch
        }
        
    }
    var parameters:Parameters{
        switch self{
        case .user:
            return Parameters()
        case let .patchUser(gender,ageRange,image,nickname,genre,_):
            var params = Parameters()
            params["gender"] = gender
            params["age_range"] = ageRange
            params["profile_image"] = image
            params["nickname"] = nickname
            params["genre"] = genre
            return params
            
        }
        
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .user:
            return request
        case .patchUser:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
    }
}
