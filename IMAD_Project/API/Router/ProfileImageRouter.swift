//
//  ProfileImageRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/8/24.
//

import Foundation
import Alamofire

enum ProfileImageRouter:URLRequestConvertible{
    
    case profileCustom(image:Data)
    case profileDefault(image:String)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .profileCustom:
            return "api/user/profile_image/custom"
        case .profileDefault:
            return "api/user/profile_image/default"
        }
    }
    var method:HTTPMethod{
        return .patch
    }
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return try URLEncoding(destination: .queryString).encode(request, with: nil)
    }
}
