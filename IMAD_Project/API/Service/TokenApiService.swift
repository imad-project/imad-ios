//
//  TokenApitService.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/11/04.
//

import Foundation
import Alamofire

enum TokenApiService{
    
    static let intercept = GetTokenIntercept()
    
    static func getToken(completion: @escaping (Bool) -> Void){
            print("토큰 재발급 api 호출")
            
//            var getTokenSuccess = false
            
            ApiClient.shared.session
                .request(TokenRouter.token,interceptor: intercept)
                .response{
                    completion(UserDefaultManager.shared.checkToken(response: $0.response))
//                    return getTokenSuccess
                }
            
        }
}
