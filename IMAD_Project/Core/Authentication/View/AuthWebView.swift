import SwiftUI
import UIKit
import WebKit
import Combine

struct AuthWebView: View {
    let webView: WKWebView = WKWebView()
    let webViewDelegate = WebViewDelegate()
    let endPoint = "/oauth2/authorization/"
    let filter: OauthFilter
    @State var loginMode = false
    @EnvironmentObject var vm: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    // WebView로드 상태 추적을 위한 delegate
    class WebViewDelegate: NSObject, WKNavigationDelegate {
        // 페이지 로드가 완료되면 호출
        var success = PassthroughSubject<(), Never>()
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            guard let httpResponse = navigationResponse.response as? HTTPURLResponse else {
                decisionHandler(.cancel)
                return
            }
//            print("액세스\(httpResponse.allHeaderFields["Authorization"] as? String ?? "") 리프레쉬\(httpResponse.allHeaderFields["authorization-refresh"] as? String ?? "")")
            
            if let accessToken = httpResponse.allHeaderFields["Authorization"] as? String{
                if let refreshToken = httpResponse.allHeaderFields["Authorization-refresh"] as? String{
                    print(accessToken)
                    print(refreshToken)
                    UserDefaultManager.shared.setToken(accessToken: accessToken, refreshToken: refreshToken)
                    success.send()
                }else if let refreshToken = httpResponse.allHeaderFields["authorization-refresh"] as? String{
                    UserDefaultManager.shared.setToken(accessToken: accessToken, refreshToken: refreshToken)
                    success.send()
                }
            }
            decisionHandler(.allow)
        }
        
        // 페이지 로드 요청에 대한 결정을 가져옴
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
    }
    
    // WebView 인스턴스 및 Delegate 생성
    var body: some View {
        VStack {
            Text(filter.text)
                .bold()
                .foregroundColor(filter.textColor)
                .padding(.vertical, 15)
            WebView(webView: webView, userAgent: "Imad Agent")
        }.background {
            Color.white
            filter != .kakao ? filter.color : filter.color.opacity(0.7)
        }
        .onAppear {
            // 로드될 페이지 설정
            var url = URL(string: "")
            if filter == .Apple {
                url = URL(string: "https://\(Bundle.main.infoDictionary?["APPLE_LOGIN_URL"] ?? "")=https://\(Bundle.main.infoDictionary?["APPLE_REDIRECT_URI"] ?? "")")!
            } else {
                url = URL(string: "\(ApiClient.baseURL)\(endPoint)\(filter.rawValue)")!
            }
            let request = URLRequest(url: url!)
            print(request)
            // WebView에 로드된 페이지에 대한 Delegate 지정
            webView.navigationDelegate = webViewDelegate
            // 로드된 페이지 요청
            webView.load(request)
        }
        .onReceive(webViewDelegate.success) { _ in
            vm.getUser()
        }
    }
}

struct WebView: UIViewRepresentable {
    let webView:WKWebView
    let userAgent: String // userAgent 프로퍼티를 추가합니다
    
    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        
        // 여기서 userAgent를 설정합니다
        webView.customUserAgent = userAgent
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    // 델리게이트 메소드를 처리할 Coordinator를 생성합니다
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        // 델리게이트 메소드를 여기서 처리합니다
    }
}

struct AuthWebView_Previews: PreviewProvider {
    static var previews: some View {
        AuthWebView(filter: .kakao)
    }
}
