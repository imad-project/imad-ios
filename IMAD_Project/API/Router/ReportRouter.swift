//
//  ReportRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/18/24.
//

import Foundation
import Alamofire

enum ReportRouter:URLRequestConvertible{
    case user(id:Int,type:String,description:String)
    case review(id:Int,type:String,description:String)
    case posting(id:Int,type:String,description:String)
    case comment(id:Int,type:String,description:String)
    
    var baseURL:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var method:HTTPMethod{
        return .post
    }
    var endPoint:String{
        switch self{
        case .user : "/api/report/user"
        case .review : "/api/report/review"
        case .posting : "/api/report/posting"
        case .comment : "/api/report/comment"
        }
    }
    var parameters:Parameters{
        switch self{
        case let .user(id, type, description):
            var params = Parameters()
            params["reported_id"] = id
            params["report_type_string"] = type
            params["report_desc"] = description
            return params
        case let .review(id, type, description):
            var params = Parameters()
            params["reported_id"] = id
            params["report_type_string"] = type
            params["report_desc"] = description
            return params
        case let .posting(id, type, description):
            var params = Parameters()
            params["reported_id"] = id
            params["report_type_string"] = type
            params["report_desc"] = description
            return params
        case let .comment(id, type, description):
            var params = Parameters()
            params["reported_id"] = id
            params["report_type_string"] = type
            params["report_desc"] = description
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        var request = URLRequest(url: url)
        request.method = method
        return try JSONEncoding.default.encode(request, with: parameters)
    }
}
