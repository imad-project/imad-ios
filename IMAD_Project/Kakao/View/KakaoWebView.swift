//
//  KakaoWebView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/12.
//

import SwiftUI
import WebKit

struct KakaoWebView: UIViewRepresentable {
        
    @EnvironmentObject var vm:KakaoAuthViewModel
    
    func makeUIView(context: Context) ->  WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let html =  vm.htmlString{
            uiView.loadHTMLString("<meta name=\"viewport\" content=\"initial-scale=1.0\" />" + html, baseURL: nil)
            print("웹뷰 \(html)")
        }
    }
}

struct KakaoWebView_Previews: PreviewProvider {
    static var previews: some View {
        KakaoWebView()
            .environmentObject(KakaoAuthViewModel())
    }
}
