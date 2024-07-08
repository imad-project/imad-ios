//
//  FormDataInterceptor.swift
//  IMAD_Project
//
//  Created by 유영웅 on 7/8/24.
//

import Foundation
import Alamofire

class FormDataInterceptor:RequestInterceptor{
    
    var requestStatus = true
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        print("폼 데이터 인터셉트")
        var urlReq = urlRequest
        let token = UserDefaultManager.shared.getToken()
        urlReq.headers.add(.authorization(bearerToken: token.accessToken))
        urlReq.headers.add(.contentType("multipart/form-data"))
        completion(.success(urlReq))
    }
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401,requestStatus else {
            print("에러 : 재로그인 시도")
            return completion(.doNotRetryWithError(error)) //액세스,리프레시 토큰을 첨부후 요청 수행했는데도 토큰발급이 불가하다면 에러반환
        }
        TokenApiService.getToken { success in
            if success{
                self.requestStatus = false
                print("토큰 재발급 후 요청 재시도")
                completion(.retry)
                
            }else{
                print("에러 : 재로그인 시도")
                completion(.doNotRetryWithError(error))
                
            }
        }
    }
}

