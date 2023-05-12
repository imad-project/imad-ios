//
//  KakaoAuthViewModel.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/06.
//

import Foundation
import Combine
import Alamofire

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
        let url = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=\(apiKey)&redirect_uri=\(baseURL)"
        AF.request(url).responseString{ response in
            guard let response = response.value else { return }
            self.htmlString = response
            self.kakoLogin.send()
            
//            print("응답값 : \(reponse)")
//            print("응답값 : \(reponse.result)")    //success/fail로 나타냄
//            print("응답값 : \(String(describing: reponse.value))") //통신 성공시에만 보여줌
        }
//        let aa = [String:Any]()
//        if (UserApi.isKakaoTalkLoginAvailable()) { //카카오앱 로그인
//            UserApi.shared.loginWithKakaoTalk {(_, error) in
//                if let error = error {
//                    print("에러 - \(error)")
//                }
//                else {
//                    print("loginWithKakaoTalk() success.")
//                }
//            }
//        }else{ //카카오웹뷰 로그인
//            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
//                    if let error = error {
//                        print(error)
//                    }
//                    else {
//                        print("loginWithKakaoAccount() success.")
//                        //do something
//                        _ = oauthToken
//                    }
//                }
//        }
    }
}
