//
//  BaseIntercept.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Alamofire

class BaseIntercept:RequestInterceptor{
    
    var requestStatus = true
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        

        var urlReq = urlRequest
        let token = UserDefaultManager.shared.getToken()
        urlReq.headers.add(.authorization(bearerToken: token.accessToken))
        completion(.success(urlReq))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        Task{
            guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
                return completion(.doNotRetryWithError(error)) //액세스,리프레시 토큰을 첨부후 요청 수행했는데도 토큰발급이 불가하다면 에러반환
            }
            if requestStatus{   //토큰 수신 한번만 하기 위함
                requestStatus = TokenApiService.getToken()
            }
            completion(.retry)
        }
    }
}

class GetTokenIntercept:RequestInterceptor{
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        let token = UserDefaultManager.shared.getToken()
        var urlReq = urlRequest
        
        urlReq.headers.add(.authorization(bearerToken: token.accessToken))
        urlReq.addValue("Bearer \(token.refreshToken)", forHTTPHeaderField: "Authorization-refresh")
        print("토큰 재발급 \(urlReq.headers)")
        completion(.success(urlReq))
    }
}
