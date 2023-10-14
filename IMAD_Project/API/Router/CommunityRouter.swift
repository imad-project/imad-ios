//
//  CommunityRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/10/14.
//

import Foundation
import Alamofire

enum CommunityRouter:URLRequestConvertible{
    
    case write(contentsId:Int,title:String,content:String,category:Int,spoiler:Bool)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .write:
            return "/api/posting"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .write:
            return .post
        }
    }
    
    var parameters:Parameters{
        switch self{
        case let .write(contentsId, title, content, category, spoiler):
            var params = Parameters()
            params["contents_id"] = contentsId
            params["title"] = title
            params["content"] = content
            params["category"] = category
            params["is_spoiler"] = spoiler
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
//        case .readList,.read,.delete,.myReview,.myLikeReview:
//            return try URLEncoding(destination: .queryString).encode(request, with: parameters)
        case .write:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
        
    }
    
}
