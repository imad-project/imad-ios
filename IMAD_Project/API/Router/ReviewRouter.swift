//
//  ReviewRouter.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/09/12.
//

import Foundation
import Alamofire

enum ReviewRouter:URLRequestConvertible{
    case createReview(id:Int,title:String,content:String,score:Double,spoiler:Bool)
    case readReview(id:Int)
    case updateReview(id:Int,title:String,content:String,score:Double,spoiler:Bool)
    case deleteReview(id:Int)
    case readReviewList(id:Int,page:Int,sort:String,order:Int)
    case updateReviewLike(id:Int,status:Int)
    case readMyReviewList(page:Int)
    case readMyLikeReviewList(page:Int,likeStatus:Int)
    
    var baseUrl:URL{
        return URL(string: ApiClient.baseURL)!
    }
    
    var endPoint:String{
        switch self{
        case .createReview:
            return "/api/review"
        case .readReview(let id),.updateReview(let id,_,_,_,_),.deleteReview(let id):
            return "/api/review/\(id)"
        case .readReviewList:
            return "/api/review/list"
        case .updateReviewLike(let id,_):
            return "/api/review/like/\(id)"
        case .readMyReviewList:
            return "api/profile/review/list"
        case .readMyLikeReviewList:
            return "/api/profile/like/review/list"
        }
    }
    
    var method:HTTPMethod{
        switch self{
        case .createReview:
            return .post
        case .readReview,.readReviewList,.readMyReviewList,.readMyLikeReviewList:
            return .get
        case .updateReview,.updateReviewLike:
            return .patch
        case .deleteReview:
            return .delete
        }
    }
    var parameters:Parameters{
        switch self{
        case let .createReview(id, title, content, score, spoiler):
            var params = Parameters()
            params["contents_id"] = id
            params["title"] = title
            params["content"] = content
            params["score"] = score
            params["is_spoiler"] = spoiler
            return params
        case let .readReviewList(id, page, sort, order):
            var params = Parameters()
            params["contents_id"] = id
            params["page"] = page
            params["sort"] = sort
            params["order"] = order
            return params
        case let .updateReview(id, title, content, score, spoiler):
            var params = Parameters()
            params["contents_id"] = id
            params["title"] = title
            params["content"] = content
            params["score"] = score
            params["is_spoiler"] = spoiler
            return params
        case let .updateReviewLike(_,status):
            var params = Parameters()
            params["like_status"] = status
            return params
        case let .readMyReviewList(page):
            var params = Parameters()
            params["page"] = page
            return params
        case let .readMyLikeReviewList(page,likeStatus):
            var params = Parameters()
            params["page"] = page
            params["like_status"] = likeStatus
            return params
        default:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseUrl.appendingPathComponent(endPoint)  //url 설정
        var request = URLRequest(url: url)
        request.method = method
        switch self{
        case .readReviewList,.readReview,.deleteReview,.readMyReviewList,.readMyLikeReviewList:
            return try URLEncoding(destination: .queryString).encode(request, with: parameters)
        default:
            return try JSONEncoding.default.encode(request, with: parameters)
        }
        
    }
}
