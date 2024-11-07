//
//  TestUserInfoView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/6/24.
//

import SwiftUI
//import Combine

// Singleton class
class AuthManager: ObservableObject {
    static let shared = AuthManager()
    @Published var isLoggedIn: Bool = true
    
    private init() {}
    
    func logout() {
        isLoggedIn = false
    }
}

struct TestUserInfoView: View {
    @StateObject private var authManager = AuthManager.shared
    
    var body: some View {
        Group {
            if authManager.isLoggedIn {
                ChildView()
            } else {
                // 로그인 화면으로 이동
                LoginView()
            }
        }
        .animation(.easeInOut, value: authManager.isLoggedIn) // 애니메이션 추가 가능
    }
}

struct ChildView: View {
    var body: some View {
        VStack {
            Text("Welcome to Child View!")
            Button("Logout") {
                AuthManager.shared.logout()
            }
        }
    }
}

struct LoginView: View {
    var body: some View {
        Text("Please log in.")
    }
}
#Preview {
    TestUserInfoView()
}
