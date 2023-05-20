//
//  TestView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/12.
//

import SwiftUI
import WebKit

struct TestView: View {
    @State private var isScrollingUp = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("adasdasd")
                    Text("adasdasd")
                    Text("adasdasd")
                    Text("adasdasd")
                }
                .background(Color.clear)
                .onPreferenceChange(OffsetPreferenceKey.self) { value in
                    isScrollingUp = value > 0 // 스크롤 방향을 감지하여 isScrollingUp 변수 업데이트
                }
            }
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .preference(
                            key: OffsetPreferenceKey.self,
                            value: proxy.frame(in: .named("scroll")).minY
                        )
                }
            )
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
            .background(headerBackground)
        }
    }
    
    private var headerBackground: some View {
        Group {
            if isScrollingUp {
                Color.red // 스크롤을 내릴 때의 백그라운드 색
            } else {
                Color.blue // 스크롤을 올릴 때의 백그라운드 색
            }
        }
        .animation(.easeInOut) // 애니메이션 적용
        .edgesIgnoringSafeArea(.top)
        .frame(height: 44)
    }
    
    private var backButton: some View {
        Button(action: {
            // 뒤로 가기 동작
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.black)
        }
    }
}

// Preference Key 정의
struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
