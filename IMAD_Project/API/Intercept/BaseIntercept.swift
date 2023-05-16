//
//  BaseIntercept.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Alamofire

class BaseIntercept:RequestInterceptor{
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        let token = UserDefaultManager.shared.getToken()
        
        var urlReq = urlRequest
        urlReq.addValue("\(token.refreshToken)", forHTTPHeaderField: "Authorization-refresh")
        urlReq.addValue("\(token.accessToken)", forHTTPHeaderField: "Authorization")
        completion(.success(urlReq))
    }
}

