//
//  WebViewDelegate.swift
//  IMAD_Project
//
//  Created by 유영웅 on 10/11/24.
//

import Foundation
import Combine
import WebKit
import SwiftUI

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
    // 델리게이트 메소드를 처리할 Coordinator를 생성
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}
// WebView로드 상태 추적을 위한 delegate
class WebViewDelegate: NSObject, WKNavigationDelegate {
    // 페이지 로드가 완료되면 호출
    var success = PassthroughSubject<(), Never>()
    var failed = PassthroughSubject<(), Never>()
    
    //페이지 로드 응답에 대한 결정을 가져옴 - response
    //페이지에서 링크나 컴포넌트를 터치할때마다 호출되는 듯함
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let httpResponse = navigationResponse.response as? HTTPURLResponse else {
            failed.send()
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
        if (200...300) ~= httpResponse.statusCode{
            if TokenManager.shared.checkToken(response: httpResponse) {
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
