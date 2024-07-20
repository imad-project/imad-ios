//
//  UserRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/16.
//

import Foundation
import Alamofire

enum UserRouter:URLRequestConvertible{
    case user
    case otherUser(id:Int)
    case patchUser(gender:String?,birthYear:Int?,nickname:String,tvGenre:[Int]?,movieGenre:[Int]?)
    case passwordChange(old:String,new:String)
    case profile
    
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .user,.patchUser:
            return "api/user"
        case .profile:
            return "api/profile"
        case .passwordChange:
            return "api/user/password"
        case let .otherUser(id):
            return "/api/profile/other/\(id)"
        }
    }
    var method:HTTPMethod{
        switch self{
        case .user,.profile,.otherUser:
            return .get
        case .patchUser,.passwordChange:
            return .patch
        }
        
    }
    var parameters:Parameters{
        switch self{
        case .user,.profile,.otherUser:
            return Parameters()
        case let .patchUser(gender,birthYear,nickname,tvGenre,movieGenre):
            var params = Parameters()
            params["gender"] = gender
            params["birth_year"] = birthYear
            params["nickname"] = nickname
            params["preferred_tv_genres"] = tvGenre
            params["preferred_movie_genres"] = movieGenre
            return params
        case let .passwordChange(old,new):
            var params = Parameters()
            params["old_password"] = old
            params["new_password"] = new
            return params
        }
    }
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        
        request.method = method
        switch self{
        case .user,.profile,.otherUser:
            return request
        case .patchUser,.passwordChange:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
    }
}
