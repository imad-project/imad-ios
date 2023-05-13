//
//  KakaoWebView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/12.
//

import SwiftUI
import WebKit


struct KakaoWebView: UIViewRepresentable {
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let webView = WKWebView()

        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<KakaoWebView>) {
        guard let url = URL(string: url) else { return }
        
        webView.load(URLRequest(url: url))
    }
}

struct KakaoWebView_Previews: PreviewProvider {
    static var previews: some View {
        KakaoWebView(url: "")
            .environmentObject(KakaoAuthViewModel())
    }
}
