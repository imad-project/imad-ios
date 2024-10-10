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
    
    // WebView로드 상태 추적을 위한 delegate
    class WebViewDelegate: NSObject, WKNavigationDelegate {
        // 페이지 로드가 완료되면 호출
        var success = PassthroughSubject<(), Never>()
        var failed = PassthroughSubject<(), Never>()
        
        //페이지 로드 응답에 대한 결정을 가져옴 - response
        //페이지에서 링크나 컴포넌트를 터피할때마다 호출되는 듯함
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            
            guard let httpResponse = navigationResponse.response as? HTTPURLResponse else {
                failed.send()
                decisionHandler(.cancel)
                return
            }
            decisionHandler(.allow)
            if (200...300) ~= httpResponse.statusCode {
                if UserDefaultManager.shared.checkToken(response: httpResponse){
                    success.send()
                }
            }
            else{
                failed.send()
            }
        }
        
        // 페이지 로드 요청에 대한 결정을 가져옴 - request
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
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
            print(url)
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

struct WebView: UIViewRepresentable {
    // userAgent를 설정 - google로그인
    let webView:WKWebView
    let userAgent: String
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {}
    
    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.customUserAgent = userAgent
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    // 델리게이트 메소드를 처리할 Coordinator를 생성합니다
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

struct AuthWebView_Previews: PreviewProvider {
    static var previews: some View {
        AuthWebView(filter: .kakao, failed: .constant(false))
           
    }
}
