//
//  GetTokenInterceptor.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/8/24.
//

import Foundation
import Alamofire

class GetTokenIntercept:RequestInterceptor{
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("토큰 인터셉터")
        let token = TokenManager.shared.getToken()
        var urlReq = urlRequest
        
        urlReq.headers.add(.authorization(bearerToken: token.accessToken))
        urlReq.addValue("Bearer \(token.refreshToken)", forHTTPHeaderField: "Authorization-refresh")
        completion(.success(urlReq))
    }
}
