////
////  AppleSignButtonView.swift
////  IMAD_Project
////
////  Created by 유영웅 on 2023/06/15.
////
//
//import SwiftUI
//import AuthenticationServices
//
//struct AppleSigninButtonView : View{
//    var body: some View{
//        SignInWithAppleButton(
//            onRequest: { request in
//                request.requestedScopes = [.fullName, .email]
//            },
//            onCompletion: { result in
//                switch result {
//                case .success(let authResults):
//                    print("Apple Login Successful")
//                    switch authResults.credential{
//                        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//                           // 계정 정보 가져오기
//                            let UserIdentifier = appleIDCredential.user
//                            let fullName = appleIDCredential.fullName
//                            let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
//                            let email = appleIDCredential.email
//                            let IdentityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
//                            let AuthorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)
//                    default:
//                        break
//                    }
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    print("error")
//                }
//            }
//        )
//        .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
//        .cornerRadius(5)
//    }
//}
//
//struct AppleSigninButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        AppleSigninButtonView()
//    }
//}
