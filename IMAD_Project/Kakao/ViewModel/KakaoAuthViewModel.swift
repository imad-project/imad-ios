//
//  KakaoAuthViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Combine
//import Alamofire
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
//import UIKit
//import SafariServices
//import AuthenticationServices

class KakaoAuthViewModel:ObservableObject{
    
    let apiKey = Bundle.main.infoDictionary?["REST_API_KEY"] ?? ""   //restApiKey
    let baseURL = "http://39.119.82.229:8080//login/oauth2/code/kakao"
    @Published var code:String? = nil
    @Published var htmlString:String? = nil
    var kakoLogin = PassthroughSubject<(),Never>()
    
    func kakaoLogout(){
//        UserApi.shared.logout {(error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("logout() success.")
//            }
//        }
    }
    func handleKakaoLogin(){
//        let url = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=\(apiKey)&redirect_uri=\(baseURL)"
//        AF.request(url).responseString{ response in
//            switch response.result {
//               case .success(let html):
//                   print("이거 \(html)")
//                    self.htmlString = url
//               case .failure(let error ):
//                   print(error)
//               }
//        }
        // 카카오 로그인 API 호출
//        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//            if let error = error {
//                print(error)
//            }
//            else {
//                print("loginWithKakaoAccount() success.")

                // 인가코드 추출
//                guard let code = oauthToken?. else {
//                    return
//                }

                // 추출된 인가코드를 이용하여 원하는 API 호출
                // ...
//            }
//        }


        
        if (UserApi.isKakaoTalkLoginAvailable()) { //카카오앱 로그인
           UserApi.shared.loginWithKakaoTalk {(_, error) in
                if let error = error {
                    print("에러 - \(error)")
                }
                else {
                    print("loginWithKakaoTalk() success.")
                }
            }
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
