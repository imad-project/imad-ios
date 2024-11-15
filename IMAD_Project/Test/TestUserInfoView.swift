//
//  TestUserInfoView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 11/6/24.
//

import SwiftUI

final class AppRootManager: ObservableObject {
    
//    @Published var currentRoot: eAppRoots = .splash
    @Published var path:[String] = []
    static let instance = AppRootManager()
    private init(){}
    
}
struct TestUserInfoView:View{
    @StateObject private var appRootManager = AppRootManager.instance
    
    var body: some View {
        NavigationStack(path: $appRootManager.path) {
            Button {
                appRootManager.path.append("\(V1())")
            } label: {
                Text("1")
            }
            .navigationDestination(for: String.self) { view in
                switch view{
                case "\(V1())":V1()
                case "\(V2())":V2()
                default:EmptyView()
                }
            }
//            .environmentObject(appRootManager)
        }
    }
}
struct V1:View {
    @StateObject private var appRootManager = AppRootManager.instance
    var body: some View {
//        NavigationStack(path: $appRootManager.path) {
            Button {
                appRootManager.path.append("\(V2())")
            } label: {
                Text("2")
            }
//            .navigationDestination(for: String.self) { view in
//                switch view{
//                case "\(V2())":
//                    V2()
//                default:
//                    Text("aaaa").onAppear{print("v3")}
//                }
//            }
//            .environmentObject(appRootManager)
//        }
    }
}
struct V2:View {
    @StateObject private var appRootManager = AppRootManager.instance
    var body: some View {
//        NavigationStack(path: $appRootManager.path) {
            Button {
                appRootManager.path.removeAll()
            } label: {
                Text("3")
            }
        
//        }
    }
}
#Preview {
    NavigationStack{
        TestUserInfoView()
    }
}
