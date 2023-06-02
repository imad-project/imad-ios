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

    var body: some Scene {
        WindowGroup {
            NavigationStack{
               ContentView()
//                MenuTabView()
//                    .environmentObject(AuthViewModel())
            }
        }
    }
}
