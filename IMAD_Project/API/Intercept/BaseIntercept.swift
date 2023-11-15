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
//    var tokenMode = false
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
//        if !tokenMode{
            print("인터셉트")
            var urlReq = urlRequest
            let token = UserDefaultManager.shared.getToken()
            urlReq.headers.add(.authorization(bearerToken: token.accessToken))
            completion(.success(urlReq))
//        }
//        else{
//            print("토큰 인터셉터")
//            let token = UserDefaultManager.shared.getToken()
//            var urlReq = urlRequest
//
//            urlReq.headers.add(.authorization(bearerToken: token.accessToken))
//            urlReq.addValue("Bearer \(token.refreshToken)", forHTTPHeaderField: "Authorization-refresh")
//            tokenMode = false
//            print("토큰 재발급 \(urlReq.headers)")
//            completion(.success(urlReq))
//        }x
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        Task{
//        DispatchQueue.main.async {
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
            return completion(.doNotRetryWithError(error)) //액세스,리프레시 토큰을 첨부후 요청 수행했는데도 토큰발급이 불가하다면 에러반환
        }
        TokenApiService.getToken { success in
            if success{
                completion(.retry)
                print("토큰 재발급 후 요청 재시도")
            }else{
                completion(.doNotRetryWithError(error))
                print("에러 : 재로그인 시도")
            }
        }
//            print("1")
//            print("\(TokenApiService.getToken()) 2")
//            print("3")
//            if !TokenApiService.getToken(){
//                print("토큰 저장 실패")
//                completion(.doNotRetryWithError(error))
//            }else{
//                print("인터셉트 재시도")
//                completion(.retry)
//            }
//        }

//        print(TokenApiService.getToken())
//        print("인터셉트 재시도")
//            let a = TokenApiService.getToken()  //true - 재요청 / falsㄷ - 종료
//            print(a)
//            if !a{
//                completion(.doNotRetryWithError(error))
//            }else{
//                completion(.retry)
//            }
//            if TokenApiService.getToken(){
//                print("토큰저장 성공")
//
//            }
//            tokenMode = true
//            if tokenMode{
//            requestStatus = TokenApiService.getToken()
//            print(requestStatus)
//            if !requestStatus{
//                requestStatus = true
//                completion(.retry)
//            }
//                completion(.retry)
//            }
//            if requestStatus{
                
//                tokenMode = TokenApiService.getToken()    //토큰 수신 한번만 하기 위함
            
                
//            }
//            else{
//                requestStatus = true
//                completion(.doNotRetryWithError(error))
//            }
//        }
    }
}

class GetTokenIntercept:RequestInterceptor{
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        print("토큰 인터셉터")
        let token = UserDefaultManager.shared.getToken()
        var urlReq = urlRequest
        
        urlReq.headers.add(.authorization(bearerToken: token.accessToken))
        urlReq.addValue("Bearer \(token.refreshToken)", forHTTPHeaderField: "Authorization-refresh")
//        print("토큰 재발급 \(urlReq.headers)")
        completion(.success(urlReq))
    }
}
