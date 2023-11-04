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
    
        static func getToken() {
            print("토큰 재발급 api 호출")
            ApiClient.shared.session
                .request(TokenRouter.token,interceptor: intercept)
                .response{ response in
    
                    var accessToken = ""
                    var refreshToken = ""
                    
                    print("요청 \(response.request?.headers)")
                    print("응답 \(response.response?.headers)")
                    
                    if let access = response.response?.allHeaderFields["Authorization"] as? String{
                        accessToken = access
                    }
                    if let refresh = response.response?.allHeaderFields["Authorization-refresh"] as? String{
                        refreshToken = refresh
                    }else if let refresh = response.response?.allHeaderFields["authorization-refresh"] as? String{
                        refreshToken = refresh
                    }
                    
                    if !accessToken.isEmpty,!refreshToken.isEmpty{
                        UserDefaultManager.shared.setToken(accessToken: accessToken, refreshToken: refreshToken)
                    }
                }
        }
}
