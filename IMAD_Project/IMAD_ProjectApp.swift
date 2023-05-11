//
//  IMAD_ProjectApp.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/03/27.
//

import SwiftUI
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

@main
struct IMAD_ProjectApp: App {
    init() {
        // Kakao SDK 초기화
        let kakaoAppkey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppkey as! String)
    }
    @StateObject var vm = KakaoAuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL{ url in
                    if let code = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.first(where: { $0.name == "code" })?.value {
                        print("인가코드: \(code)")
                        vm.code = code
                    } else {
                        print("인가코드 추출 실패")
                    }
                }
        }
    }
}
