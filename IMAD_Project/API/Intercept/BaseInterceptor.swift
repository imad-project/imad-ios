//
//  BaseIntercept.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Alamofire

class BaseIntercept:RequestInterceptor{
    
    var requestStatus = true    //토큰 재발급 무한루프 방지
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
            print("인터셉트")
            var urlReq = urlRequest
            let token = TokenManager.shared.getToken()
            urlReq.headers.add(.authorization(bearerToken: token.accessToken))
            completion(.success(urlReq))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {

        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401,requestStatus else {
            print("에러 : 재로그인 시도A")
            return completion(.doNotRetryWithError(error)) //액세스,리프레시 토큰을 첨부후 요청 수행했는데도 토큰발급이 불가하다면 에러반환
        }
        TokenApiService.getToken { success in
            if success{
                self.requestStatus = false
                print("토큰 재발급 후 요청 재시도")
                completion(.retry)
                
            }else{
                print("에러 : 재로그인 시도B")
                completion(.doNotRetryWithError(error))
                
            }
        }
    }
}

