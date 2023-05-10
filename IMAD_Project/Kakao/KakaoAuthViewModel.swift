//
//  KakaoAuthViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser

class KakaoAuthViewModel:ObservableObject{
    
    
    func kakaoLogout(){
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }
    func handleKakaoLogin(){
        if (UserApi.isKakaoTalkLoginAvailable()) { //카카오앱 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print("에러 - \(error)")
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    //print("카카오 정보 ; \(oauthToken)")
                    //do something
                    _ = oauthToken
                    //AuthApiService.kakaoAuth(code: oauthToken., status: <#T##Int#>)
                }
            }
           // AuthApi.shared.authorizeRequest(parameters: [String : Any])
        }else{ //카카오웹뷰 로그인
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("loginWithKakaoAccount() success.")
                        //do something
                        _ = oauthToken
                    }
                }
        }
    }
}
