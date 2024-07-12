//
//  OnBoardingTabView.swift
//  IMAD_Project
//
//  Created by 유영웅 on 2023/05/26.
//

import SwiftUI

struct OnBoardingTabView: View {
    
    @State var page = 0
    @Binding var isFirstLaunch:Bool
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            LinearGradient(colors: [Color.customIndigo,Color.customIndigo.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            TabView(selection: $page) {
                OnBoardingView(title: "리뷰", descrpit: "재밌게 본 드라마나 영화에 대해 마음껏 본인의 생각을 펼쳐보세요!", image: "ghost", height: 250)
                    .tag(0)
                OnBoardingView(title: "커뮤니티", descrpit: "마음맞는 사람과 \n본인의 작품관에 대해 토론해 보세요!", image: "communication", height: 300)
                    .tag(1)
            }.ignoresSafeArea()
            .tabViewStyle(.page(indexDisplayMode: .never))
            HStack{
                if page == 0 {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 20,height:10)
                        .frame(maxHeight: .infinity,alignment: .top)
                        .foregroundColor(.white)
                    Circle()
                        .frame(width: 10,height:10)
                        .frame(maxHeight: .infinity,alignment: .top)
                        .foregroundColor(.white.opacity(0.5))
                }else{
                    Circle()
                        .frame(width: 10,height:10)
                        .frame(maxHeight: .infinity,alignment: .top)
                        .foregroundColor(.white.opacity(0.5))
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 20,height:10)
                        .frame(maxHeight: .infinity,alignment: .top)
                        .foregroundColor(.white)
                }
            }
            .padding(.top)
            
            Button {
                if page == 0 {
                    withAnimation(.linear){
                        page = 1
                    }
                }else{
                    withAnimation(.linear){
                        UserDefaults.standard.set(true, forKey: "isFirstLaunch")
                        isFirstLaunch = true
                    }
                }
            } label: {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white.opacity(page == 0 ? 0.8:1.0))
                    .frame(height: 60)
                    .overlay {
                        Text(page == 0 ? "다음" : "시작").foregroundColor(.customIndigo.opacity(page == 0 ? 0.7:1.0))
                            .font(.GmarketSansTTFMedium(18))
                    }

            }
            .padding(.horizontal,20)
            .padding(.bottom)
            .frame(maxHeight: .infinity,alignment: .bottom)
        }.background{
            Color.white.ignoresSafeArea()
            Color.gray.opacity(0.2).ignoresSafeArea()
        }
       
    }
}

struct OnBoardingTabView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingTabView(isFirstLaunch: .constant(false))
    }
}
