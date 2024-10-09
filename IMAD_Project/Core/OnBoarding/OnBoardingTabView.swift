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
            tabView
            indicatorView
            nextButtonView
        }
        .backgroundColor{ backgroundColor }
    }
}

struct OnBoardingTabView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingTabView(isFirstLaunch: .constant(false))
    }
}

extension OnBoardingTabView{
    func indicator(_ condition:Bool)->some View{
        RoundedRectangle(cornerRadius: 5)
            .frame(width: condition ? 20:10,height:10)
            .frame(maxHeight: .infinity,alignment: .top)
            .foregroundColor(.white)
            .opacity(condition ? 1:0.5)
    }
    var backgroundColor:some View{
        ZStack{
            Color.black.ignoresSafeArea()
            LinearGradient(colors: [Color.customIndigo,Color.customIndigo.opacity(0.5)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
    }
    var tabView:some View{
        TabView(selection: $page) {
            OnBoardingView(title: "리뷰", descrpit: "재밌게 본 드라마나 영화에 대해 마음껏 본인의 생각을 펼쳐보세요!", image: "ghost", height: 250)
                .tag(0)
            OnBoardingView(title: "커뮤니티", descrpit: "마음맞는 사람과 \n본인의 작품관에 대해 토론해 보세요!", image: "communication", height: 300)
                .tag(1)
        }
        .ignoresSafeArea()
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
    var indicatorView:some View{
        HStack{
            indicator(page == 0)
            indicator(page == 1)
        }
        .padding(.top)
    }
    var nextButtonView:some View{
        CustomConfirmButton(text: page == 0 ? "다음" : "시작", color: .white, textColor: .customIndigo) {
            withAnimation(.linear){
                page == 0 ? page = 1 : UserDefaults.standard.set(true, forKey: "isFirstLaunch")
                isFirstLaunch = true
            }
        }
        .opacity(page == 0 ? 0.7:1.0)
        .padding([.horizontal,.bottom],20)
        .frame(maxHeight: .infinity,alignment: .bottom)
    }
}

