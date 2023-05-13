//
//  TestView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/12.
//

import SwiftUI

struct TestView: View {
    let apiKey = Bundle.main.infoDictionary?["REST_API_KEY"] ?? ""   //restApiKey
    let baseURL = "http://39.119.82.229:8080//login/oauth2/code/kakao"
    let authURL = "https://kauth.kakao.com/oauth/authorize?client_id=\(Bundle.main.infoDictionary?["REST_API_KEY"] ?? "")&redirect_uri=http://39.119.82.229:8080//login/oauth2/code/kakao&response_type=code"
        
        @State private var authorizationCode: String?
        
        var body: some View {
            VStack {
                Button("카카오 로그인") {
//                    guard let url = URL(string: authURL) else { return }
//                    if let kakaoTalkUrl = URL(string: "kakaotalk://inweb?url=\(authURL)") {
//                        UIApplication.shared.open(kakaoTalkUrl)
//                    }
                    guard let url = URL(string: authURL) else { return }
                               UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                
                if let authorizationCode = authorizationCode {
                    Text("인가코드: \(authorizationCode)")
                    
                }
            }
            .onOpenURL { url in
                guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
                      let queryItems = components.queryItems else { return }
                
                for queryItem in queryItems {
                    if queryItem.name == "code", let authorizationCode = queryItem.value {
                        self.authorizationCode = authorizationCode
                    }
                }
            }
        }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
