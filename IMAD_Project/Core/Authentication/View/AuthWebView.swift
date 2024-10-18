import SwiftUI
import UIKit
import WebKit
import Combine

struct AuthWebView: View {
    let webView: WKWebView = WKWebView()
    let webViewDelegate = WebViewDelegate()
    
    let filter: OauthFilter
    @State var loginMode = false
    @Binding var failed:Bool
    @EnvironmentObject var vm: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var endPoint:String{
        switch filter{
        case .Apple:
            return "/oauth2/login/"
        default:
            return "/oauth2/authorization/"
        }
    }
    // WebView 인스턴스 및 Delegate 생성
    var body: some View {
        VStack {
            Text(filter.text)
                .font(.GmarketSansTTFMedium(15))
                .foregroundColor(filter.textColor)
                .padding(.vertical, 15)
            WebView(webView: webView, userAgent: "Imad Agent")
        }.background {
            Color.white
            filter.color
        }
        .onAppear {
            // 로드될 페이지 설정
            let url = URL(string: "\(ApiClient.baseURL)\(endPoint)\(filter.authProvierName)")!
            // WebView에 로드된 페이지에 대한 Delegate 지정
            webView.navigationDelegate = webViewDelegate
            // 로드된 페이지 요청
            webView.load(URLRequest(url: url))
        }
        .onReceive(webViewDelegate.success) {
            dismiss()
            vm.getUser()
        }
        .onReceive(webViewDelegate.failed){
            dismiss()
            failed = true
        }
    }
}



#Preview{
    AuthWebView(filter: .kakao, failed: .constant(false))
        .environmentObject(AuthViewModel(user: CustomData.user))
}



